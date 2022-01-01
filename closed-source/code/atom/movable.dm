
/atom/movable
	var/anchored = FALSE

/atom/movable/Bump(var/atom/obstacle)
	. = ..()
	obstacle.Bumped(src)
