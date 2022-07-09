
VAR_GLOBAL(controller/networks/networks_controller)

/// Networks Controller
/controller/networks
	priority = PRIORITY_LOW
	tick_rate = 1
	name = "Networks"

/controller/smoothing/New()
	. = ..()
	GLOBALS.smoothing_controller = src

/controller/smoothing/process()
	. = ..()
	for (var/datum/network/N)
		N.process()

/world/init_controllers(datum/scheduler/scheduler)
	. = ..()
	scheduler.add_controller(new /controller/networks())
