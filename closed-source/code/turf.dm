/turf
	vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_ID
	plane = PLANE_TURF

/turf/proc/has_visible_atom()
	for (var/atom/A in src.contents)
		if (A.is_visible())
			return TRUE
	return FALSE

/turf/basic/floor
	name = "floor"
	icon = 'assets/cc-by-sa-nc/icons/turf/floors.dmi'
	icon_state = "floor"

/turf/basic/plating
	name = "floor"
	icon = 'assets/cc-by-sa-nc/icons/turf/floors.dmi'
	icon_state = "plating"

/turf/basic/lattice
	name = "lattice"
	icon = 'assets/cc-by-sa-nc/icons/obj/structures.dmi'
	icon_state = "lattice"

/turf/basic/wall
	name = "wall"
	icon = 'assets/cc-by-sa-nc/icons/turf/wall.dmi'
	icon_state = "wall"
	opacity = TRUE
	density = TRUE

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
