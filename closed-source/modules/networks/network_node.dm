/**
Network Nodes

Intended to be subclassed, this is a generic network piece object that forms [/datum/network]s
**/
/obj/structure/network_node
	VAR_PRIVATE/datum/network/network = null
	var/enabled = TRUE
	icon = 'assets/cc-by-sa-nc/icons_new/obj/network/debug.dmi'
	icon_state = "0-1"
	var/list/dirs = list()
	needs_init = TRUE
	var/offset = NET_OFFSET_MIDDLE
	var/z_layer = NET_LAYER_PLATING
	var/node_kind = NET_KIND_UNDEFINED
	var/list/obj/machine/connected_devices = list()

/obj/structure/network_node/New()
	. = ..()
	var/tmp_icon = src.icon_state
	src.dirs = splittext(tmp_icon, "-")

/// Handles joining networks
/obj/structure/network_node/Initialise()
	. = ..()

	// Set ourselves to be invisible if we're on a tile
	if (istype(src.loc, /turf/basic/open/floor))
		src.invisibility = VISIBLITY_UNDER_TILE

	// If we don't have a network, we need one!
	if (isnull(src.network))
		var/list/obj/structure/network_node/neighbours = src.potential_neighbours()
		if (neighbours.len == 0)
			// We have no neighbours, so create a new network
			src.network = src.create_network(list(src))
		else
			for (var/N in neighbours)
				var/obj/structure/network_node/node = N
				if (!isnull(node.network))
					// The other node has a network!
					if (isnull(src.network))
						// We don't have one, let's join!
						src.set_network(node.network)
					else if(node.network != src.network)
						// We have one, and it's different from the other, have the smaller net merge into the bigger one
						if (node.network.nodes.len > src.network.nodes.len)
							src.network.merge_into(node.network)
						else
							node.network.merge_into(src.network)
				else
					// The other node does not have a network, propagate the graph outwards and form a new net with it
					var/list/obj/structure/network_node/new_graph = node.build_node_graph()
					src.create_network(new_graph)

/// Destructor, handles leaving networks
/obj/structure/network_node/Del()
	enabled = FALSE
	src.network.on_node_remove(src)
	var/list/obj/structure/network_node/neighbours = src.potential_neighbours()

	if (neighbours.len > 1)
		// If we have more than one neighbour, we need to make sure we don't split the net in two
		for (var/N in neighbours)
			var/obj/structure/network_node/node = N
			if (node.network != src.network)
				// Ignore other networks
				continue
			else
				// Build a graph from this other neighbour, and confirm it matches out net's graph
				var/list/obj/structure/network_node/new_graph = node.build_node_graph()
				var/list/obj/structure/network_node/prime_graph = src.network.nodes

				if (new_graph.len != prime_graph.len || length(new_graph ^ prime_graph) > 0)
					// The graph does not match, so we split the net. Make a new net using the smaller subset.
					var/list/obj/structure/network_node/inverted_nodes = prime_graph - new_graph
					if (length(new_graph) < length(inverted_nodes))
						src.create_network(new_graph)
					else
						src.create_network(inverted_nodes)
					continue
	. = ..()

/// Sets the network for this node
/obj/structure/network_node/proc/set_network(datum/network/new_network)
	if (!isnull(src.network))
		src.network.on_node_remove(src)
	src.network = new_network
	src.network.on_node_add(src)

/// Designed to be overriden
/obj/structure/network_node/proc/can_connect_to(obj/structure/network_node/node)
	return (src.offset == node.offset && src.z_layer == node.z_layer)

/// Can these two nodes connect?
/obj/structure/network_node/proc/_is_neighbour_candidate(obj/structure/network_node/node)
	if (!node || !node.enabled || get_dist(src, node) > 1 || src.node_kind != node.node_kind)
		return FALSE

	var/list/invert_dir_map = list("0" = 0, "[NORTH]" = SOUTH, "[SOUTH]" = NORTH, "[EAST]" = WEST, "[WEST]" = EAST)  
	var/dir_to_them = 0
	var/dir_from_them = 0
	if (src.loc != node.loc)
		dir_to_them = get_dir(src.loc, node.loc)
		dir_from_them = invert_dir_map["[dir_to_them]"]

	var/we_can_connect = src.dirs.Find("[dir_to_them]") != FALSE
	var/they_can_connect = node.dirs.Find("[dir_from_them]") != FALSE

	return we_can_connect && they_can_connect

/// Builds the node graph
/obj/structure/network_node/proc/build_node_graph(var/list/nodes = list(src))
	var/list/neighbours = src.potential_neighbours()
	for (var/obj/structure/network_node/node in neighbours)
		if (!nodes.Find(node))
			nodes.Add(node)
			node.build_node_graph(nodes)
	return nodes

/// Get all the potential connections
/obj/structure/network_node/proc/potential_neighbours()
	var/list/neighbours = list()

	for (var/dir in src.dirs)
		dir = text2num(dir)
		if (dir == 0)
			for (var/obj/structure/network_node/node in src.loc)
				if (src._is_neighbour_candidate(node))
					neighbours.Add(node)
			continue
		for (var/obj/structure/network_node/node in get_step(src, dir))
			if (src._is_neighbour_candidate(node))
				neighbours.Add(node)

	neighbours.Remove(src)

	return neighbours

/// Create a fresh instance of the network type
/obj/structure/network_node/proc/create_network(var/list/nodes)
	switch (src.node_kind)
		if (NET_KIND_POWER) return new /datum/network/power(nodes)
		if (NET_KIND_ATMOS) return new /datum/network/atmos(nodes)
		else				return new /datum/network(nodes)

/obj/structure/network_node/proc/add_device(var/obj/machine/machine)
	src.connected_devices.Add(machine)
	src.network.on_device_add(machine)

/obj/structure/network_node/proc/remove_device(var/obj/machine/machine)
	src.connected_devices.Remove(machine)
	src.network.on_device_remove(machine)
	machine.on_network_lost()
