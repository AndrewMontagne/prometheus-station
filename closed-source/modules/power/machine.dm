/obj/machine/power
	var/obj/structure/network_node/power/connected_node = null

/obj/machine/power/proc/connect_to_node()
	for (var/obj/structure/network_node/power/P in src.loc)
		if ("0" in P.dirs)
			P.add_device(src)
			src.connected_node = P
			return TRUE
	return FALSE

