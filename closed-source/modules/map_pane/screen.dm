/**
Screen Object

Ancestor for all GUI objects.
**/
/obj/screen
	mouse_over_pointer = MOUSE_HAND_POINTER
	plane = PLANE_SCREEN
	var/width = 32
	var/height = 32

/obj/screen/Del()
	if (src.loc && istype(src.loc, /obj/toolbar))
		var/obj/toolbar/T = src.loc
		T.remove_screen(src)

	. = ..()
