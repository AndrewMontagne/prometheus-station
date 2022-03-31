
VAR_GLOBAL(controller/smoothing/smoothing_controller)

/// Icon Smoothing Controller
/controller/smoothing
	priority = PRIORITY_LOW
	tick_rate = 1
	name = "Icon Smoothing"

	/*
	These two being static might seem superfluous, and it is, but it solves
	a circular dependency in the world loading process. For now.

	TODO: Future me, make this better.
	*/
	VAR_STATIC(list/icon_cache) = list()
	VAR_STATIC(list/atoms_to_smooth) = list()

/controller/smoothing/New()
	. = ..()
	GLOBALS.smoothing_controller = src

/controller/smoothing/process()
	. = ..()
	for (var/i in src.atoms_to_smooth)
		var/atom/A = i
		A.icon_smooth()
	src.atoms_to_smooth = list()

/world/init_controllers(datum/scheduler/scheduler)
	. = ..()
	scheduler.add_controller(new /controller/smoothing())
