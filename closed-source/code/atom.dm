/atom
	var/anchored = FALSE

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
