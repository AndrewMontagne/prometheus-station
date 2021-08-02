
/datum/toolbar
	var/datum/map_pane/map = null
	var/v_anchor = "BOTTOM"
	var/h_anchor = "CENTER"
	var/list/screens = list()
	var/is_horizontal = TRUE

/datum/toolbar/New(var/datum/map_pane/_map, var/list/_screens)
	src.map = _map
	src.map.listeners.Add(src)
	src.screens = _screens
	src.update()

/datum/toolbar/Del()
	src.map.listeners.Remove(src)
	. = ..()

/datum/toolbar/proc/update()
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
