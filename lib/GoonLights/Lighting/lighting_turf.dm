/turf
	var/dynamic_lighting = TRUE
	luminosity           = 1

	var/tmp/lighting_corners_initialised = FALSE

	var/tmp/list/datum/light_source/affecting_lights       // List of light sources affecting this turf.
	var/tmp/atom/movable/lighting_overlay/lighting_overlay // Our lighting overlay.
	var/tmp/list/datum/lighting_corner/corners
	var/tmp/has_opaque_atom = FALSE // Not to be confused with opacity, this will be TRUE if there's any opaque atom on the tile.

/turf/New()
	. = ..()

	if(opacity)
		has_opaque_atom = TRUE

// Causes any affecting light sources to be queued for a visibility update, for example a door got opened.
/turf/proc/reconsider_lights()
	for(var/light in affecting_lights)
		var/datum/light_source/L = light
		L.vis_update()

/turf/proc/lighting_clear_overlay()
	if(lighting_overlay)
		returnToPool(lighting_overlay)

	for(var/corner in corners)
		var/datum/lighting_corner/C = corner
		C.update_active()

// Builds a lighting overlay for us, but only if our area is dynamic.
/turf/proc/lighting_build_overlay()
	if(lighting_overlay)
		return

	var/area/A = loc
	if(A.dynamic_lighting)
		if (!lighting_corners_initialised)
			generate_missing_corners()
		getFromPool(/atom/movable/lighting_overlay, src)

		for(var/corner in corners)
			var/datum/lighting_corner/C = corner
			if(!C.active) // We would activate the corner, calculate the lighting for it.
				for(var/L in C.affecting)
					var/datum/light_source/S = L
					S.recalc_corner(C)

				C.active = TRUE

// Used to get a scaled lumcount.
/turf/proc/get_lumcount(var/minlum = 0, var/maxlum = 1)
	if(!lighting_overlay)
		return 0.5

	var/totallums = 0
	for(var/light in corners)
		var/datum/light_source/L = light
		totallums += L.lum_r + L.lum_b + L.lum_g

	totallums /= 12 // 4 corners, each with 3 channels, get the average.

	totallums = (totallums - minlum) / (maxlum - minlum)

	return CLAMP01(totallums)

// Can't think of a good name, this proc will recalculate the has_opaque_atom variable.
/turf/proc/recalc_atom_opacity()
	has_opaque_atom = FALSE
	for(var/atom/A in src.contents + src) // Loop through every movable atom on our tile PLUS ourselves (we matter too...)
		if(A.opacity)
			has_opaque_atom = TRUE

// If an opaque movable atom moves around we need to potentially update visibility.
/turf/Entered(var/atom/movable/Obj, var/atom/OldLoc)
	. = ..()

	if(Obj && Obj.opacity)
		has_opaque_atom = TRUE // Make sure to do this before reconsider_lights(), incase we're on instant updates. Guaranteed to be on in this case.
		reconsider_lights()

/turf/Exited(var/atom/movable/Obj, var/atom/newloc)
	. = ..()

	if(Obj && Obj.opacity)
		recalc_atom_opacity() // Make sure to do this before reconsider_lights(), incase we're on instant updates.
		reconsider_lights()

/turf/proc/set_dynamic_lighting(var/on)
	if (on && !src.dynamic_lighting)
		lighting_build_overlay()
		src.reconsider_lights()
	else if (!on && src.dynamic_lighting)
		lighting_clear_overlay()
	src.dynamic_lighting = on

/turf/change_area(var/area/old_area, var/area/new_area)
	if(new_area.dynamic_lighting != old_area.dynamic_lighting)
		if(new_area.dynamic_lighting)
			lighting_build_overlay()
		else if (lighting_overlay)
			lighting_clear_overlay()

/turf/proc/generate_missing_corners()
	lighting_corners_initialised = TRUE
	if (!corners)
		corners = list(null, null, null, null)
	for (var/i = 1 to 4)
		if (corners[i]) // Already have a corner on this direction.
			continue
		corners[i] = new/datum/lighting_corner(src, LIGHTING_CORNER_DIAGONAL[i])

/turf/proc/get_corners()
	if(has_opaque_atom)
		return null // Since this proc gets used in a for loop, null won't be looped though.

	return corners

// So the thing is, making things like lighting overlay data persist when a turf gets replaced is sort of hard...
// As such, whenever you're causing a turf's type to change, use this proc to do it.
// If you don't, the lighting engine will not approve of your shenanigans.
/turf/proc/change_turf(var/new_type)
	// Back all this data up, so we can set it after the turf replace.
	// If you're wondering how this proc'll keep running since the turf should be "deleted":
	// BYOND never deletes turfs, when you "delete" a turf, it actually morphs the turf into a new one.
	// Running procs do NOT get stopped due to this.

	var/l_overlay     = lighting_overlay // Not even a need to cast this, honestly.
	var/affect_lights = affecting_lights
	var/l_corners     = corners
	var/old_dynamic   = dynamic_lighting
	var/old_opacity   = opacity

	// Create the new turf, replacing us.
	new new_type(src)

	lighting_corners_initialised = TRUE
	recalc_atom_opacity()

	lighting_overlay  = l_overlay
	affecting_lights  = affect_lights
	corners           = l_corners

	if((old_opacity != opacity) || (dynamic_lighting != old_dynamic))
		reconsider_lights()

	if(old_dynamic != dynamic_lighting)
		if(dynamic_lighting)
			lighting_build_overlay()

		else
			lighting_clear_overlay()

	src.queue_for_smoothing()
