/atom
	plane = PLANE_GAME

/// Finds and returns the parent turf of an atom.
/atom/proc/find_turf()
	RETURN_TYPE(/turf)

	var/atom/resolved_loc = src.loc

	while (!isturf(resolved_loc))
		if (isnull(resolved_loc))
			break
		
		resolved_loc = resolved_loc.loc

	return resolved_loc

/atom/proc/is_visible()
	if (istype(src, /atom/movable/lighting_overlay))
		return FALSE
	if (src.invisibility > 0)
		return FALSE
	if (src.alpha == 0)
		return FALSE
	return TRUE


/atom/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	if(!usr || !over) 
		return
	if(over == src)
		return usr.client.Click(src, src_location, src_control, params)
	if(!Adjacent(usr) || !over.Adjacent(usr)) 
		return // should stop you from dragging through windows

	over.MouseDropOn(src,usr,params)
	return

/atom/proc/MouseDropOn(atom/dropping, mob/user, params)
	return

/atom/proc/Adjacent(atom/neighbour)
	var/turf/self_origin = src.find_turf()
	var/turf/other_origin = neighbour.find_turf()

	if (isnull(self_origin) || isnull(other_origin))
		return FALSE

	if (self_origin.z != other_origin.z)
		return FALSE

	if (abs(self_origin.x - other_origin.x) > 1)
		return FALSE

	if (abs(self_origin.y - other_origin.y) > 1)
		return FALSE

	return TRUE

/atom/proc/update_icon()
	src.overlays.Cut()
	src.underlays.Cut()

/atom/var/needs_init = FALSE
/atom/proc/Initialise()
	src.needs_init = FALSE

/atom/Del()
	if (src.smoothing_type != SMOOTHING_NONE)
		src.queue_for_smoothing(FALSE)
	. = ..()

/atom/New(var/atom/location, var/list/params=null, var/auto_init=TRUE)
	SHOULD_CALL_PARENT(TRUE)
	. = ..(location)

	if (!isnull(params))
		for (var/variable in params)
			src.vars[variable] = params[variable]
	if (src.smoothing_type != SMOOTHING_NONE)
		src.queue_for_smoothing(TRUE)
	if (auto_init)
		spawn(0)
			src.Initialise()

/atom/proc/Bumped(var/atom/movable/source)
	return
