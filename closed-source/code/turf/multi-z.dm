
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


/turf/basic/open/void
	icon = 'assets/cc-by-sa-nc/icons_new/areas.dmi'
	icon_state = "void"

/turf/basic/open/void/Entered(atom/movable/A, atom/OldLoc)
	. = ..()

	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		spawn(1)
			A.z = A.z + 1
			if (istype(A, /mob))
				var/mob/M = A
				M.stdout("\red You fell!")

/turf/basic/open/void/New()
	. = ..()
	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		src.needs_init = TRUE

/turf/basic/open/void/Initialise()
	. = ..()
	if (src.z >= MULTI_Z_START && src.z < MULTI_Z_END)
		src.vis_contents.Add(locate(src.x, src.y, src.z + 1))

/turf/basic/open/stairs/up
	icon_state = "stairs-up"

/turf/basic/open/stairs/up/Exit(var/atom/movable/O, var/newloc)
	if (newloc == get_step(src, src.dir))
		O.z--
		spawn(1)
			step(O, src.dir)
		return FALSE
	else
		return TRUE

/turf/basic/open/stairs/down
	icon_state = "stairs-down"

/turf/basic/open/stairs/down/Exit(var/atom/movable/O, var/newloc)
	if (newloc == get_step(src, src.dir))
		O.z++
		spawn(1)
			step(O, src.dir)
		return FALSE
	else
		return TRUE
