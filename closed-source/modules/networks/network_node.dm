
/obj/network_node
	VAR_PRIVATE/datum/network/network = null
	var/enabled = TRUE
	icon = 'cc-by-sa-nc/icons/obj/power.dmi'
	icon_state = "sp_base"

/obj/network_node/New()
	. = ..()
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

///
/obj/network_node/proc/set_network(datum/network/new_network)
	if (!isnull(src.network))
		src.network.on_node_remove(src)
	src.network = new_network
	src.network.on_node_add(src)


/// Can these two nodes connect?
/obj/network_node/proc/can_connect_to(obj/network_node/node)
	return (get_dist(src, node) <= 1) & node.enabled

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

	for (var/obj/network_node/node in locate(src.x, src.y, src.z))
		if (src.can_connect_to(node))
			neighbours.Add(node)
	for (var/obj/network_node/node in locate(src.x + 1, src.y, src.z))
		if (src.can_connect_to(node))
			neighbours.Add(node)
	for (var/obj/network_node/node in locate(src.x - 1, src.y, src.z))
		if (src.can_connect_to(node))
			neighbours.Add(node)
	for (var/obj/network_node/node in locate(src.x, src.y + 1, src.z))
		if (src.can_connect_to(node))
			neighbours.Add(node)
	for (var/obj/network_node/node in locate(src.x, src.y - 1, src.z))
		if (src.can_connect_to(node))
			neighbours.Add(node)

	neighbours.Remove(src)

	return neighbours

/obj/network_node/verb/destroy()
	set src in oview()
	del(src)

/mob/verb/makenode()
	new /obj/network_node(src.loc)
