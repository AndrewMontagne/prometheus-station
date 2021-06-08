/turf/proc/has_visible_atom()
	for (var/atom/A in src.contents)
		if (A.is_visible())
			return TRUE
	return FALSE

/turf/basic/floor
	name = "floor"
	icon = 'cc-by-sa-nc/icons/turf/floors.dmi'
	icon_state = "floor"

/turf/basic/wall
	name = "wall"
	icon = 'cc-by-sa-nc/icons/turf/wall.dmi'
	icon_state = "wall"
	opacity = 1
	density = 1
