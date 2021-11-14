
/obj/toolbar
	var/datum/map_pane/map = null
	var/v_anchor = "BOTTOM"
	var/h_anchor = "CENTER"
	var/list/screens = list()
	var/is_horizontal = TRUE

/obj/toolbar/New(var/datum/map_pane/_map, var/list/_screens)
	src.map = _map
	src.map.listeners.Add(src)

	for (var/obj/screen/S in _screens)
		src.add_screen(S)

/obj/toolbar/Del()
	src.map.listeners.Remove(src)
	. = ..()

/obj/toolbar/proc/add_screen(var/obj/screen/S)
	LOG_TRACE("ADD SCREEN")
	screens.Add(S)
	S.loc = src
	update()

/obj/toolbar/proc/remove_screen(var/obj/screen/S)
	LOG_TRACE("REMOVE SCREEN")
	screens.Remove(S)
	update()

/obj/toolbar/proc/update()
	var/total_size = 0
	for (var/obj/screen/S in src.screens)
		if (src.is_horizontal)
			total_size += S.width
		else
			total_size += S.height
	var/position = 16 - (total_size / 2)
	for (var/obj/screen/S in src.screens)
		if (src.is_horizontal)
			S.screen_loc = "[src.h_anchor]:[position],[src.v_anchor]"
			position += S.width
