/// Lighting controller
/controller/lighting
	name = "Lighting"
	priority = PRIORITY_MEDIUM

/controller/lighting/New()
	. = ..()
	create_all_lighting_overlays()

/controller/lighting/process()
	. = ..()
	lighting_process()
