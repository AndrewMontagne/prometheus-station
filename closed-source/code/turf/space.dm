/turf/space
	name = "space"
	desc = "The final frontier."
	icon = 'assets/cc-by-sa-nc/icons/turf/space.dmi'
	icon_state = "black"
	name = "space"
	dynamic_lighting = FALSE

/turf/space/New()
	. = ..()
	src.icon_state = "transparent"
