
/datum/network
	var/list/obj/network_node/nodes = list()
	var/colour

/datum/network/New(list/obj/network_node/new_graph)
	src.colour = rgb(rand(1,255), rand(1,255), rand(1,255))
	for (var/N in new_graph)

		var/obj/network_node/node = N
		node.set_network(src)

/datum/network/Del()
	for (var/N in src.nodes)
		var/obj/network_node/node = N
		node.color = "#ffffff"

/datum/network/proc/on_node_add(obj/network_node/node)
	node.color = src.colour
	src.nodes.Add(node)

/datum/network/proc/on_node_remove(obj/network_node/node)
	src.nodes.Remove(node)
	node.color = "#ffffff"
	if (nodes.len == 0)
		del(src)

/datum/network/proc/merge_into(datum/network/other_network)
	for (var/N in src.nodes)
		var/obj/network_node/node = N
		node.set_network(other_network)
