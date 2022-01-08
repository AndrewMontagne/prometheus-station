/turf/basic/open
	icon = 'assets/cc-by-sa-nc/icons/turf/floors.dmi'

/turf/basic/open/floor
	name = "floor"
	icon_state = "floor"

/turf/basic/open/plating
	name = "floor"
	icon = 'assets/cc-by-sa-nc/icons_new/turf/floors/smooth/plating.dmi'
	icon_state = "plating"
	smoothing_type = SMOOTHING_SIMPLE

/turf/basic/open/plating/New()
	. = ..()
	src.queue_for_smoothing()
