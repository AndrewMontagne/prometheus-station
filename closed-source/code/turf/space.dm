/turf/space
	icon = 'cc-by-sa-nc/icons/turf/space.dmi'
	name = "space"
	icon_state = "0"

	dynamic_lighting = TRUE

/turf/space/New()
	icon = 'cc-by-sa-nc/icons/turf/space.dmi'
	icon_state = "black"
	setup_lighting_overlay()

/turf/space/proc/setup_lighting_overlay()
	if (src.lighting_overlay)
		src.show_lighting_overlay = src.has_visible_atom()
		src.lighting_overlay.color = src.show_lighting_overlay ? src.lighting_overlay.computed_color : rgb(0,0,0,0)
	else
		spawn(10)
			setup_lighting_overlay()

/turf/space/Entered(atom/movable/A)
	if (!A.is_visible())
		return ..()
	if (src.show_lighting_overlay != TRUE)
		src.show_lighting_overlay = TRUE
		src.lighting_overlay.update_overlay()
	. = ..()
	
/turf/space/Exited(atom/movable/Obj, atom/newloc)
	spawn (3)
		var/new_visible = src.has_visible_atom()
		if (src.show_lighting_overlay != new_visible)
			src.show_lighting_overlay = new_visible
			src.lighting_overlay.update_overlay()
	. = ..()
