
/atom
	var/smoothing_type = SMOOTHING_NONE

/atom/proc/queue_for_smoothing()
	atoms_to_smooth |= list(src)

/atom/proc/icon_smooth()
	if (src.smoothing_type != SMOOTHING_SIMPLE)
		return

	var/edges = 0
	if (src.can_smooth_with(get_step(src, NORTH)))
		edges |= SMOOTHING_DIR_N
	if (src.can_smooth_with(get_step(src, EAST)))
		edges |= SMOOTHING_DIR_E
	if (src.can_smooth_with(get_step(src, SOUTH)))
		edges |= SMOOTHING_DIR_S
	if (src.can_smooth_with(get_step(src, WEST)))
		edges |= SMOOTHING_DIR_W

	var/corners = 0
	if (src.can_smooth_with(get_step(src, NORTHEAST)))
		corners |= SMOOTHING_DIR_NE
	if (src.can_smooth_with(get_step(src, NORTHWEST)))
		corners |= SMOOTHING_DIR_NW
	if (src.can_smooth_with(get_step(src, SOUTHEAST)))
		corners |= SMOOTHING_DIR_SE
	if (src.can_smooth_with(get_step(src, SOUTHWEST)))
		corners |= SMOOTHING_DIR_SW

	var/cachekey = "[src.icon]-[edges]-[corners]"

	var/cached_icon = icon_smoothing_cache[cachekey]
	if (!isnull(cached_icon))
		src.icon = cached_icon
		return

	var/icon/I = icon(src.icon, src.icon_state)
	var/list/pieces = icon_smoothing_lut["[edges][corners]"]

	for (var/piece in pieces)
		I.Blend(icon(src.icon, piece), ICON_OVERLAY)

	src.icon = I

/atom/proc/can_smooth_with(var/atom/neighbor)
	return istype(neighbor, src.type)
