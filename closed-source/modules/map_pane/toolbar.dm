
/obj/screen/toolbar
	var/datum/map_pane/map = null
	var/list/screens = list()
	var/is_horizontal = TRUE
	var/align = ANCHOR_CENTER

/obj/screen/toolbar/New(var/datum/map_pane/_map, var/list/_screens)
	src.map = _map
	src.map.listeners.Add(src)

	src.h_anchor = ANCHOR_CENTER
	src.v_anchor = ANCHOR_BOTTOM

	for (var/obj/screen/S in _screens)
		src.add_screen(S)

/obj/screen/toolbar/Del()
	src.map.listeners.Remove(src)
	. = ..()

/obj/screen/toolbar/proc/add_screen(var/obj/screen/S)
	LOG_TRACE("ADD SCREEN")
	screens.Add(S)
	S.loc = src
	update()

/obj/screen/toolbar/proc/remove_screen(var/obj/screen/S)
	LOG_TRACE("REMOVE SCREEN")
	screens.Remove(S)
	update()

/obj/screen/toolbar/proc/update()
	var/total_size = 0
	for (var/obj/screen/S in src.screens)
		if (src.is_horizontal)
			total_size += S.width
		else
			total_size += S.height

	var/position = 16 - (total_size / 2)

	if (src.is_horizontal)
		if (src.h_anchor == ANCHOR_LEFT)
			position = 0
		else if (src.h_anchor == ANCHOR_RIGHT)
			position = -total_size + 32
	else
		if (src.v_anchor == ANCHOR_TOP)
			position = -total_size + 32
		else if (src.v_anchor == ANCHOR_BOTTOM)
			position = 0

	for (var/obj/screen/S in src.screens)
		S.v_anchor = src.v_anchor
		S.h_anchor = src.h_anchor
		S.x_offset = src.x_offset
		S.y_offset = src.y_offset
		if (src.is_horizontal)
			S.x_offset += position
			S.update_screen_loc()
			position += S.width
		else
			S.y_offset += position
			S.update_screen_loc()
			position += S.height
