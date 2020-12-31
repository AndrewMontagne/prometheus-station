/atom
    plane = PLANE_GAME

/turf/space
    plane = PLANE_SPACE

/mob/Move()
	. = ..()
	if (client && client.eye == src)
		src.client.update_parallax()
	
/client
	/// The client-specific parallax HUD element
    VAR_PRIVATE/obj/screen/space/parallax = null

/// Lazy loads the parallax for the client
/client/proc/get_parallax()
	if(isnull(parallax))
		parallax = new()
	return parallax

/// Updates the parallax for this client
/client/proc/update_parallax()
	// If the client approaches the edge of the world, change the plane of the parallax so that it renders on top of 
	// "darkness" tiles, so that the end of the world is effectively invisible.
	if (src.mob.x < 12 || src.mob.x > (world.maxx - 12) || src.mob.y < 12 || src.mob.y > (world.maxy - 12))
		src.parallax.plane = 1
	else
		src.parallax.plane = PLANE_PARALLAX
