
/obj/screen/toolbar
	var/list/screens = list()
	var/is_horizontal = FALSE
	var/align = ANCHOR_CENTER
	var/max_width = 0
	var/max_height = 0
	var/mob/mob_loc = null

/obj/screen/toolbar/New(var/atom/_loc, var/list/_screens, var/_is_horizontal, var/_align=ANCHOR_CENTER, var/_h_anchor=ANCHOR_CENTER, var/_v_anchor=ANCHOR_CENTER)
	src.loc = _loc

	if (istype(src.loc, /mob))
		src.mob_loc = src.loc
	else if (istype(src.loc, /obj/screen/toolbar))
		var/obj/screen/toolbar/T = src.loc
		src.mob_loc = T.mob_loc

	if (isnull(src.mob_loc))
		EXCEPTION("NO MOB_LOC FOR TOOLBAR")

	src.is_horizontal = _is_horizontal

	src.h_anchor = _h_anchor
	src.v_anchor = _v_anchor
	src.align = _align

	for (var/obj/screen/S in _screens)
		src.add_screen(S, FALSE)

	mob_loc.rebuild_screen()

/obj/screen/toolbar/Del()
	. = ..()

/obj/screen/toolbar/proc/add_screen(var/obj/screen/S)
	mob_loc.ui.Add(S)
	screens.Add(S)
	S.loc = src
	update_size()
	mob_loc.rebuild_screen()

/obj/screen/toolbar/proc/remove_screen(var/obj/screen/S)
	mob_loc.ui.Remove(S)
	screens.Remove(S)
	update_size()
	mob_loc.rebuild_screen()

/obj/screen/toolbar/proc/update_size()
	var/total_size = 0
	src.max_height = 0
	src.max_width = 0

	for (var/obj/screen/S in src.screens)
		if (S.width > max_width)
			src.max_width = S.width
		if (S.height > max_height)
			src.max_height = S.height
		if (src.is_horizontal)
			total_size += S.width
		else
			total_size += S.height

	if (src.is_horizontal)
		src.width = total_size
		src.height = src.max_height
	else
		src.height = total_size
		src.width = src.max_width

	if (istype(src.loc, /obj/screen/toolbar))
		var/obj/screen/toolbar/parent_toolbar = src.loc
		parent_toolbar.update_size()
	else
		src.update_position()

/obj/screen/toolbar/proc/update_position()

	if (istype(src.loc, /obj/screen/toolbar))
		var/obj/screen/toolbar/parent_toolbar = src.loc
		src.h_anchor = parent_toolbar.h_anchor
		src.v_anchor = parent_toolbar.v_anchor

	var/total_size = 0
	if (src.is_horizontal)
		total_size = src.width
	else
		total_size = src.height

	var/position = 0
	if (!istype(src.loc, /obj/screen/toolbar))
		if (src.is_horizontal)
			if (src.h_anchor == ANCHOR_LEFT)
				position = 0
			else if (src.h_anchor == ANCHOR_RIGHT)
				position = -total_size + 32
			else if (src.h_anchor == ANCHOR_CENTER)
				position = -(total_size / 2) + 16

			if (src.v_anchor == ANCHOR_TOP)
				src.y_offset = 32 - src.max_height
			if (src.v_anchor == ANCHOR_CENTER)
				src.y_offset = 16 - (src.max_height / 2)
		else
			if (src.v_anchor == ANCHOR_TOP)
				position = -total_size + 32
			else if (src.v_anchor == ANCHOR_BOTTOM)
				position = 0
			else if (src.v_anchor == ANCHOR_CENTER)
				position = -(total_size / 2) + 16

			if (src.h_anchor == ANCHOR_RIGHT)
				src.x_offset = 32 - src.max_width
			if (src.h_anchor == ANCHOR_CENTER)
				src.x_offset = 16 - (src.max_width / 2)

	for (var/obj/screen/S in src.screens)
		S.v_anchor = src.v_anchor
		S.h_anchor = src.h_anchor
		S.x_offset = src.x_offset
		S.y_offset = src.y_offset
		if (src.is_horizontal)
			if (S.height != src.max_height)
				if (src.align == ANCHOR_TOP)
					S.y_offset += (src.max_height - S.height)
				else if (src.align == ANCHOR_CENTER)
					S.y_offset += (src.max_height / 2) - (S.height / 2)
				else
					S.y_offset = src.y_offset
			S.x_offset += position
			S.update_screen_loc()
			position += S.width
		else
			if (S.width != max_width)
				if (src.align == ANCHOR_RIGHT)
					S.x_offset += (src.max_width - S.width)
				else if (src.align == ANCHOR_CENTER)
					S.x_offset += (src.max_width / 2) - (S.width / 2)
				else 
					S.x_offset = src.x_offset
			S.y_offset -= position
			S.update_screen_loc()
			position += S.height
		if (istype(S, /obj/screen/toolbar))
			var/obj/screen/toolbar/child_toolbar = S
			child_toolbar.update_position()
