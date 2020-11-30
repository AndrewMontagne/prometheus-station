
/obj/network_node
	var/datum/network/network = null
	icon = 'cc-by-sa-nc/icons/obj/power.dmi'
	icon_state = "sp_base"

/obj/network_node/New()
	. = ..()
	spawn(1)
		if (isnull(src.network))
			network = new /datum/network(src)

/// Can these two nodes connect?
/obj/network_node/proc/can_connect_to(obj/network_node/node)
	return get_dist(src, node) <= 1

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
