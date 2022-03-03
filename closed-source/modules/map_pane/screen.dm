/**
All UI elements are instances of this
**/
/obj/screen
	mouse_over_pointer = MOUSE_HAND_POINTER
	plane = PLANE_SCREEN
	/// The width of the element, in pixels
	var/width = 32
	/// The height of the element, in pixels
	var/height = 32
	/// The vertical anchoring of the element in the window
	var/v_anchor = ANCHOR_CENTER
	/// The horizontal anchoring of the element in the winfow
	var/h_anchor = ANCHOR_CENTER
	/// The horizontal offset of the element in the window, in pixels
	var/x_offset = 0
	/// The vertical offset of the element in the window, in pixels
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

/// Updates the screen_loc of the object using the `h_anchor`, `x_offset`, `v_anchor` and `y_offset` variables
/obj/screen/proc/update_screen_loc()
	src.screen_loc = "[src.h_anchor]:[src.x_offset],[src.v_anchor]:[src.y_offset]"
