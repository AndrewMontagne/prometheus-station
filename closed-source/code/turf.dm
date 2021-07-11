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

/turf/MouseDropOn(obj/O as obj, mob/player/user as mob)
	if (istype(O,/obj/item))
		var/obj/item/I = O
		if (I.equipped)
			if (I.slot.can_unequipitem())
				I.slot.unequipitem()
			else
				return
		I.loc = src

/turf/find_turf()
	return src
