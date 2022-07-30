/turf
	plane = PLANE_GAME

/// Returns whether a given turf has a visible atom.
/turf/proc/has_visible_atom()
	for (var/atom/A in src.contents)
		if (A.is_visible())
			return TRUE
	return FALSE

/turf/MouseDropOn(obj/O as obj, mob/player/user as mob, params)
	if (istype(O,/obj/item))
		var/obj/item/I = O
		if (I.equipped)
			if (I.slot.can_unequipitem())
				I.slot.unequipitem()
			else
				return
		var/list/P = params2list(params)
		I.pixel_x = text2num(P["icon-x"]) - 16
		I.pixel_y = text2num(P["icon-y"]) - 16
		I.loc = src

/turf/find_turf()
	return src
