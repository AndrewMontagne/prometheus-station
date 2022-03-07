
/atom
	/// What is the smoothing type for this atom?
	var/smoothing_type = SMOOTHING_NONE

/// Queues a given atom to be smoothed on the next controller tick
/atom/proc/queue_for_smoothing(var/include_self = TRUE)
	var/list/dirty = list()
	if (include_self)
		dirty.Add(src)

	for(var/dir in ALL_DIRS)
		var/turf/T = get_step(src, dir)
		if (src.can_smooth_with(T))
			dirty.Add(T)
		for (var/atom/A in T.contents)
			if (src.can_smooth_with(A))
				dirty.Add(A)

	atoms_to_smooth |= dirty

/// Smooths an atom. Should only be called by [/controller/smoothing]
/atom/proc/icon_smooth()
	if (src.smoothing_type == SMOOTHING_NONE)
		return

	src.icon = initial(src.icon)

	var/edges = 0
	if (src.check_smoothing_neighbour(get_step(src, NORTH)))
		edges |= SMOOTHING_DIR_N
	if (src.check_smoothing_neighbour(get_step(src, EAST)))
		edges |= SMOOTHING_DIR_E
	if (src.check_smoothing_neighbour(get_step(src, SOUTH)))
		edges |= SMOOTHING_DIR_S
	if (src.check_smoothing_neighbour(get_step(src, WEST)))
		edges |= SMOOTHING_DIR_W

	var/corners = 0
	if (src.check_smoothing_neighbour(get_step(src, NORTHEAST)))
		corners |= SMOOTHING_DIR_NE
	if (src.check_smoothing_neighbour(get_step(src, NORTHWEST)))
		corners |= SMOOTHING_DIR_NW
	if (src.check_smoothing_neighbour(get_step(src, SOUTHEAST)))
		corners |= SMOOTHING_DIR_SE
	if (src.check_smoothing_neighbour(get_step(src, SOUTHWEST)))
		corners |= SMOOTHING_DIR_SW

	var/cachekey = "[src.icon]-[edges]-[corners]"

	var/cached_icon = icon_smoothing_cache[cachekey]
	if (!isnull(cached_icon))
		src.icon = cached_icon
		return

	var/icon/I = icon(src.icon, "base")
	var/list/pieces = icon_smoothing_lut["[edges][corners]"]

	for (var/piece in pieces)
		I.Blend(icon(src.icon, piece), ICON_OVERLAY)

	src.icon = I

/// Checks the turf for tiles to smooth with.
/atom/proc/check_smoothing_neighbour(var/turf/T)
	if (src.can_smooth_with(T))
		return TRUE
	/// Optimisation to speed up tile smoothing for turfs
	if (src.smoothing_type != SMOOTHING_TURFS)
		if (src.smoothing_type == SMOOTHING_STRUCTS)
			for (var/obj/structure/A in T.contents)
				if (src.can_smooth_with(A))
					return TRUE
		else
			for (var/atom/A in T.contents)
				if (src.can_smooth_with(A))
					return TRUE
	return FALSE

/// Intended to be overriden. Can we smooth with this atom?
/atom/proc/can_smooth_with(var/atom/neighbor)
	return istype(neighbor, src.type)
