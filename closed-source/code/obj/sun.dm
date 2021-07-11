/obj/sun
	name = "light"
	desc = "light"
	icon = 'assets/cc-by-sa-nc/icons/obj/lighting.dmi'
	icon_state = "tube1"
	anchored = TRUE

/obj/sun/New()
	..()
	set_light(l_power = 2, l_range = 6, l_color = "#FFFFEE")

/obj/sun/verb/change_color(var/new_color as color)
	set src in view()
	set_light(l_color = new_color)

/obj/sun/verb/change_range(var/new_range as num)
	set src in view()
	set_light(new_range)

	if(!light_range)
		icon_state = "lamp-off"

/obj/sun/verb/change_power(var/new_power as num)
	set src in view()
	set_light(l_power = new_power)
