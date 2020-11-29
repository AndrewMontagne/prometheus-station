/// Finds and returns the parent turf of an atom.
/atom/proc/find_turf()
	RETURN_TYPE(/turf)

	var/atom/resolved_loc = src.loc

	while (!isturf(resolved_loc))
		if (isnull(resolved_loc))
			break
		
		resolved_loc = resolved_loc.loc

	return resolved_loc
