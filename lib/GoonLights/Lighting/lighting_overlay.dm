/atom/movable/lighting_overlay
	name             	= ""

	icon             	= 'lib/GoonLights/Lighting/icon.png'
	color            	= LIGHTING_BASE_MATRIX

	mouse_opacity    	= 0
	layer            	= LIGHTING_LAYER
	plane				= PLANE_DARKNESS
	anchored		 	= 1
	infra_luminosity 	= 256

	vis_flags           = VIS_HIDE 

	var/computed_color		= rgb(0,0,0,255)

	blend_mode       = BLEND_MULTIPLY

	var/needs_update = FALSE

/atom/movable/lighting_overlay/New(var/atom/loc, var/no_update = FALSE)
	. = ..()
	verbs.Cut()

	var/turf/T         = loc // If this runtimes atleast we'll know what's creating overlays in things that aren't turfs.
	T.lighting_overlay = src
	T.luminosity       = 0

	if(no_update)
		return

	update_overlay()

/atom/movable/lighting_overlay/Destroy()
	#ifndef LIGHTING_INSTANT_UPDATES
	global.lighting_update_overlays     -= src
	global.lighting_update_overlays_old -= src
	#endif

	var/turf/T = loc
	if(istype(T))
		T.lighting_overlay = null
		T.luminosity = 1

	..()

#define OVERLAY_ANIMATION_TICKS 2

/atom/movable/lighting_overlay/proc/update_overlay()
	var/turf/T = loc
	if(!istype(T)) // Erm...
		if(loc)
			warning("A lighting overlay realised its loc was NOT a turf (actual loc: [loc], [loc.type]) in update_overlay() and got pooled!")

		else
			warning("A lighting overlay realised it was in nullspace in update_overlay() and got pooled!")

		returnToPool(src)
		return

	// To the future coder who sees this and thinks
	// "Why didn't he just use a loop?"
	// Well my man, it's because the loop performed like shit.
	// And there's no way to improve it because
	// without a loop you can make the list all at once which is the fastest you're gonna get.
	// Oh it's also shorter line wise.
	// Including with these comments.

	// See LIGHTING_CORNER_DIAGONAL in lighting_corner.dm for why these values are what they are.
	// No I seriously cannot think of a more efficient method, fuck off Comic.
	var/datum/lighting_corner/cr  = T.corners[3] || dummy_lighting_corner
	var/datum/lighting_corner/cg  = T.corners[2] || dummy_lighting_corner
	var/datum/lighting_corner/cb  = T.corners[4] || dummy_lighting_corner
	var/datum/lighting_corner/ca  = T.corners[1] || dummy_lighting_corner

	var/max = max(cr.cache_mx, cg.cache_mx, cb.cache_mx, ca.cache_mx)

	var/turf_is_dark = max < LIGHTING_SOFT_THRESHOLD //T.get_lumcount() < 0.1
	if(!turf_is_dark)
		T.luminosity = TRUE

	src.computed_color = list(
		cr.cache_r, cr.cache_g, cr.cache_b, 0,
		cg.cache_r, cg.cache_g, cg.cache_b, 0,
		cb.cache_r, cb.cache_g, cb.cache_b, 0,
		ca.cache_r, ca.cache_g, ca.cache_b, 0,
		0, 0, 0, 1
	)

	animate(src, color = src.computed_color, OVERLAY_ANIMATION_TICKS, 1, QUAD_EASING)
	
	if(turf_is_dark)
		spawn(OVERLAY_ANIMATION_TICKS) T.luminosity = FALSE


