// It's like doing loc = someplace, except it calls Crossed(), Entered() and Exited() wherever appropriate.
// This is needed to notify the light source that we've updated.
/atom/movable/proc/forceMove(var/atom/new_loc)
	if(loc)
		loc.Exited(src, new_loc)

	var/atom/old_loc = loc

	loc = new_loc

	if(loc) // Moving to nullspace is a perfectly valid usage of this proc.
		loc.Entered(src, old_loc)

	for(var/atom/movable/AM in loc)
		AM.Crossed(src)
