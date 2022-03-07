
var/global/list/atoms_to_smooth = list()
var/global/list/icon_smoothing_cache = list()

/// Icon Smoothing Controller
/controller/smoothing
	priority = PRIORITY_LOW
	tick_rate = 1
	name = "Icon Smoothing"

/controller/smoothing/process()
	. = ..()
	for (var/i in atoms_to_smooth)
		var/atom/A = i
		A.icon_smooth()
	atoms_to_smooth = list()

/world/init_controllers(datum/scheduler/scheduler)
	. = ..()
	scheduler.add_controller(new /controller/smoothing())
