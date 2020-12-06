/turf/space
	icon = 'cc-by-sa-nc/icons/turf/space.dmi'
	name = "space"
	icon_state = "0"

	dynamic_lighting = FALSE

/turf/space/New()
	icon = 'cc-by-sa-nc/icons/turf/space.dmi'
	icon_state = "black"

	// Sun, for global illumination.
	if (((src.y + 8) % 16 == 0))
		var/dy = round((src.y + 8) / 16)
		var/offset = (dy % 2) == 0 ? 9 : 0
		if ((src.x + offset) % 18 == 0)
			new /obj/sun(src)

