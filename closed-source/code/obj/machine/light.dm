/obj/machine/light
	name = "light"
	desc = "light"
	icon = 'assets/cc-by-sa-nc/icons_new/obj/lights.dmi'
	icon_state = "tube1"
	anchored = TRUE

/obj/machine/light/Initialise()
	. = ..()
	set_light(l_power = 1, l_range = 6, l_color = "#cccccc")

/obj/machine/light/process()
	//
