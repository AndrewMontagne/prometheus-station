
/datum/network
	var/list/obj/network_node/nodes
	var/colour

/datum/network/New(obj/network_node/startnode)
	src.colour = rgb(rand(1,255), rand(1,255), rand(1,255))
	src.nodes = startnode.build_node_graph()
	for (var/N in nodes)
		var/obj/network_node/node = N
		node.network = src
		node.color = src.colour
