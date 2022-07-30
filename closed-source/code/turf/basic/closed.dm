/turf/basic/closed
	name = "wall"
	icon = 'assets/cc-by-sa-nc/icons_new/turf/walls/smooth/wall.dmi'
	icon_state = "placeholder"
	opacity = TRUE
	density = TRUE
	smoothing_type = SMOOTHING_TURFS


/turf/basic/closed/reinforced
	name = "reinforced wall"
	icon = 'assets/cc-by-sa-nc/icons_new/turf/walls/smooth/reinforced_wall.dmi'
	icon_state = "placeholder"
	smoothing_type = SMOOTHING_TURFS

/turf/basic/closed/rock
	name = "rock"
	icon = 'assets/cc-by-sa-nc/icons_new/turf/walls/smooth/rock.dmi'
	icon_state = "rock1,1"
	smoothing_type = SMOOTHING_TURFS

/turf/basic/closed/rock/New()
	. = ..()
	src.icon_state = "rock[src.x % 3],[src.y % 3]"

/obj/basic/closed/rock/can_smooth_with(atom/neighbor)
	return istype(neighbor, /turf/basic/closed/rock)


