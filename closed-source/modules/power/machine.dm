/obj/machine/power
	var/obj/structure/network_node/power/connected_node = null
	var/joule_output_buffer = 0 // All power devices are potential providers, even if they never do
	var/joules_output = 0
	var/joules_output_last = 0

/obj/machine/power/process()
	. = ..()
	src.joules_output_last = src.joules_output
	src.joules_output = 0

/obj/machine/power/proc/consume_energy(var/joules)
	if (src.joule_output_buffer == 0)
		return 0
	if (joules > src.joule_output_buffer)
		joules = src.joule_output_buffer

	src.joule_output_buffer -= joules
	return joules

/obj/machine/power/proc/connect_to_node()
	for (var/obj/structure/network_node/power/P in src.loc)
		if ("0" in P.dirs)
			P.add_device(src)
			src.connected_node = P
			return TRUE
	return FALSE

