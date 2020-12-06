/turf/
	var/show_lighting_overlay = TRUE

/turf/proc/has_visible_atom()
	for (var/atom/A in src.contents)
		if (A.is_visible())
			return TRUE
	return FALSE
