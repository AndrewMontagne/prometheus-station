/obj/machine/light
	name = "light"
	desc = "light"
	icon = 'assets/cc-by-sa-nc/icons_new/obj/lights.dmi'
	icon_state = "tube1"
	anchored = TRUE
	var/default_range = 6
	var/default_color = "#cccccc"
	layer = LAYER_CEIL

/obj/machine/light/bulb
	icon_state = "bulb1"
	default_color = "#8f8f8f"

/obj/machine/light/Initialise()
	. = ..()
	set_light(l_power = 1, l_range = src.default_range, l_color = src.default_color)

/obj/machine/light/process()
	//
