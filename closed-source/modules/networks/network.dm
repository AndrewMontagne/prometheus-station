/**
Network Datum

Intended to be subclassed, this is the logical "network" datum for [/obj/structure/network_node]s to use
**/
/datum/network
	var/list/obj/structure/network_node/nodes = list()
	var/list/obj/machine/connected_devices = list()
	var/colour

/datum/network/New(list/obj/structure/network_node/new_graph)
	src.colour = rgb(rand(1,255), rand(1,255), rand(1,255))
	for (var/N in new_graph)
		var/obj/structure/network_node/node = N
		node.set_network(src)

/datum/network/Del()
	for (var/N in src.nodes)
		var/obj/structure/network_node/node = N
		node.color = "#ffffff"

/datum/network/proc/process()

/// Fired when a node is added to the network
/datum/network/proc/on_node_add(obj/structure/network_node/node)
	src.connected_devices |= node.connected_devices
	node.color = src.colour
	src.nodes.Add(node)

/// Fired when a node is removed from the network
/datum/network/proc/on_node_remove(obj/structure/network_node/node)
	src.nodes.Remove(node)
	src.connected_devices ^= node.connected_devices
	node.color = "#ffffff"
	if (nodes.len == 0)
		del(src)

/// Merges this network into the other network
/datum/network/proc/merge_into(datum/network/other_network)
	for (var/N in src.nodes)
		var/obj/structure/network_node/node = N
		node.set_network(other_network)

