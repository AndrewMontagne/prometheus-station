/turf/basic/closed
	name = "wall"
	icon = 'assets/cc-by-sa-nc/icons_new/turf/walls/smooth/wall.dmi'
	icon_state = "wall"
	opacity = TRUE
	density = TRUE
	smoothing_type = SMOOTHING_SIMPLE


/turf/basic/closed/New()
	. = ..()
	src.queue_for_smoothing()
