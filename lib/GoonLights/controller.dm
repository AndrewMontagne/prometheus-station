/**
The Lighting Controller

This controller hooks in the GoonLights lighting processing into the task scheduler.
**/
/controller/lighting
	name = "Lighting"
	priority = PRIORITY_MEDIUM

/controller/lighting/New()
	. = ..()
	create_all_lighting_overlays()

/controller/lighting/process()
	. = ..()
	lighting_process()
