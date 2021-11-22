/**
Screen Object

Ancestor for all GUI objects.
**/
/obj/screen
	mouse_over_pointer = MOUSE_HAND_POINTER
	plane = PLANE_SCREEN
	var/width = 32
	var/height = 32
	var/v_anchor = ANCHOR_CENTER
	var/h_anchor = ANCHOR_CENTER
	var/x_offset = 0
	var/y_offset = 0


/obj/screen/New(var/atom/_loc)
	src.loc = _loc
	if (src.loc && istype(src.loc, /mob))
		var/mob/M = src.loc
		M.ui.Add(src)
		if (M.client)
			M.rebuild_screen()
	else if (src.loc && istype(src.loc, /obj/screen/toolbar))
		var/obj/screen/toolbar/T = src.loc
		T.add_screen(src)

/obj/screen/Del()
	if (src.loc && istype(src.loc, /obj/screen/toolbar))
		var/obj/screen/toolbar/T = src.loc
		T.remove_screen(src)
	else if (src.loc && istype(src.loc, /mob))
		var/mob/M = src.loc
		M.ui.Remove(src)
		M.rebuild_screen()
	. = ..()

/obj/screen/proc/update_screen_loc()
	src.screen_loc = "[src.h_anchor]:[src.x_offset],[src.v_anchor]:[src.y_offset]"
