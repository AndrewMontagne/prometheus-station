/obj/machine/power/provider
	var/generation_capacity = 0

/obj/machine/power/provider/process()
	. = ..()
	if (isnull(src.connected_node))
		src.connect_to_node()
	
	src.joules_output += (src.generation_capacity - src.joule_output_buffer)
	src.joule_output_buffer = src.generation_capacity

/obj/machine/power/provider/rtg
	icon = 'assets/cc-by-sa-nc/icons_new/obj/machine/provider.dmi'
	icon_state = "rtg"
	name = "rtg"
	desc = "As with most of life's problems, this one can be solved by a box of pure radiation."
	generation_capacity = WATTS(500)

/obj/machine/power/provider/solar
	icon = 'assets/cc-by-sa-nc/icons_new/obj/machine/provider.dmi'
	icon_state = "solar"
	name = "solar"
	desc = "Converts incident solar radiation to energy."
	generation_capacity = WATTS(100)
