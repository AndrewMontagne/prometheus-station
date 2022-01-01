
/mob/vis_flags = VIS_INHERIT_LAYER
/obj/vis_flags = VIS_INHERIT_LAYER
/atom/movable/vis_flags = VIS_INHERIT_LAYER
/turf/vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_ID | VIS_UNDERLAY

/turf/space/New()
	. = ..()
	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		src.needs_init = TRUE

/turf/space/Initialise()
	. = ..()
	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		src.vis_contents.Add(locate(src.x, src.y, src.z + 1))

/turf/space/New()
	. = ..()
	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		src.needs_init = TRUE

/turf/space/Initialise()
	. = ..()
	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		src.vis_contents.Add(locate(src.x, src.y, src.z + 1))
