/turf/space
	icon = 'assets/cc-by-sa-nc/icons/turf/space.dmi'
	name = "space"
	icon_state = "transparent"
	dynamic_lighting = FALSE
	color = "#808080"

/turf/space/New()
	. = ..()
	if (src.z == 1)
		src.needs_init = TRUE

/turf/space/Initialise()
	. = ..()
	if (src.z == 1)
		src.vis_contents.Add(locate(src.x, src.y, 2))
