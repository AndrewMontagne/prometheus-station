/**
Network Nodes

Intended to be subclassed, this is a generic network piece object that forms [/datum/network]s
**/
/obj/network_node
	VAR_PRIVATE/datum/network/network = null
	var/enabled = TRUE
	icon = 'assets/cc-by-sa-nc/icons_new/obj/cable.dmi'
	icon_state = "0-1"
	var/list/dirs = list()

/// Constructor, handles joining networks
/obj/network_node/New()
	. = ..()
	
	for (var/dir in splittext(src.icon_state, "-"))
		dirs.Add(text2num(dir))

	if (isnull(src.network))
		var/list/obj/network_node/neighbours = src.potential_neighbours()
		if (neighbours.len == 0)
			src.network = new /datum/network(list(src))
		else
			for (var/N in neighbours)
				var/obj/network_node/node = N
				if (!isnull(node.network))
					if (isnull(src.network))
						src.set_network(node.network)
					else if(node.network != src.network)
						if (node.network.nodes.len > src.network.nodes.len)
							src.network.merge_into(node.network)
						else
							node.network.merge_into(src.network)
				else
					var/list/obj/network_node/new_graph = node.build_node_graph()
					new /datum/network(new_graph)

/// Destructor, handles leaving networks
/obj/network_node/Del()
	enabled = FALSE
	src.network.on_node_remove(src)
	var/list/obj/network_node/neighbours = src.potential_neighbours()
	if (neighbours.len > 1)
		var/datum/network/network_prime = null
		for (var/N in neighbours)
			var/obj/network_node/node = N
			if (isnull(network_prime))
				network_prime = node.network
				continue
			else if (node.network != network_prime)
				continue
			else
				var/list/obj/network_node/new_graph = node.build_node_graph()
				var/list/obj/network_node/prime_graph = network_prime.nodes
				if (new_graph.len != prime_graph.len)
					new /datum/network(new_graph)
					continue
				var/list/xor_nodes = new_graph ^ prime_graph
				if (xor_nodes.len > 0)
					new /datum/network(new_graph)
					continue
	. = ..()

/// Sets the network for this node
/obj/network_node/proc/set_network(datum/network/new_network)
	if (!isnull(src.network))
		src.network.on_node_remove(src)
	src.network = new_network
	src.network.on_node_add(src)


/// Can these two nodes connect?
/obj/network_node/proc/can_connect_to(obj/network_node/node)
	if (!node || !node.enabled || get_dist(src, node) > 1)
		return FALSE

	var/list/my_dirs = splittext(src.icon_state, "-")
	var/list/their_dirs = splittext(node.icon_state, "-")

	var/list/invert_dir_map = list("0" = 0, "[NORTH]" = SOUTH, "[SOUTH]" = NORTH, "[EAST]" = WEST, "[WEST]" = EAST)  
	var/dir_to_them = 0
	var/dir_from_them = 0
	if (src.loc != node.loc)
		dir_to_them = get_dir(src.loc, node.loc)
		dir_from_them = invert_dir_map["[dir_to_them]"]

	var/we_can_connect = my_dirs.Find("[dir_to_them]") != FALSE
	var/they_can_connect = their_dirs.Find("[dir_from_them]") != FALSE

	return we_can_connect && they_can_connect

/// Builds the node graph
/obj/network_node/proc/build_node_graph(var/list/nodes = list(src))
	var/list/neighbours = src.potential_neighbours()
	for (var/obj/network_node/node in neighbours)
		if (!nodes.Find(node))
			nodes.Add(node)
			node.build_node_graph(nodes)
	return nodes

/// Get all the potential connections
/obj/network_node/proc/potential_neighbours()
	var/list/neighbours = list()

	if (0 in src.dirs)
		for (var/obj/network_node/node in src.loc)
			if (src.can_connect_to(node))
				neighbours.Add(node)
	
	for (var/dir in src.dirs)
		if (dir == 0)
			continue
		for (var/obj/network_node/node in get_step(src, dir))
			if (src.can_connect_to(node))
				neighbours.Add(node)

	neighbours.Remove(src)

	return neighbours

/mob/verb/makenode()
	new /obj/network_node(src.loc)
