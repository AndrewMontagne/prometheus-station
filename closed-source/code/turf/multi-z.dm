
/mob/vis_flags = VIS_INHERIT_LAYER
/obj/vis_flags = VIS_INHERIT_LAYER
/atom/movable/vis_flags = VIS_INHERIT_LAYER
/turf/vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_ID | VIS_UNDERLAY

/turf/space
	color = "#808080"

/turf/space/New()
	. = ..()
	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		src.needs_init = TRUE

/turf/space/Initialise()
	. = ..()
	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		src.vis_contents.Add(locate(src.x, src.y, src.z + 1))


/turf/basic/open/void
	icon = 'assets/cc-by-sa-nc/icons_new/areas.dmi'
	icon_state = "void"
	color = "#b1b1b1"
	dynamic_lighting = FALSE

/turf/basic/open/void/Entered(atom/movable/A, atom/OldLoc)
	. = ..()

	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		if (locate(src.x, src.y, src.z + 1).density)
			return
		spawn(1)
			A.z = A.z + 1
			if (istype(A, /mob))
				var/mob/M = A
				if (!istype(M.loc, /turf/basic/open/stairs))
					M.stdout("\red You fell!")

/turf/basic/open/void/New()
	. = ..()
	icon_state = "transparent"
	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		src.needs_init = TRUE

/turf/basic/open/void/Initialise()
	. = ..()
	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		src.vis_contents.Add(locate(src.x, src.y, src.z + 1))

/turf/basic/open/stairs
	icon_state = "stairs2"

/turf/basic/open/stairs/Enter(var/atom/movable/O, var/oldloc)
	if (oldloc == get_step(src, src.dir))
		return FALSE
	else
		return TRUE

/turf/basic/open/stairs/Exit(var/atom/movable/O, var/newloc)
	if (newloc == get_step(src, src.dir))
		O.z--
		spawn(1)
			step(O, src.dir)
		return FALSE
	else
		return TRUE
