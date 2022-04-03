
VAR_GLOBAL(controller/simple_ui/ui_controller)

/controller/simple_ui
	name = "SimpleUI Controller"
	priority = PRIORITY_MEDIUM
	tick_rate = 5
	var/list/datum/simple_ui/processing_uis = list()

/controller/simple_ui/New()
	. = ..()
	GLOBALS.ui_controller = src

/controller/simple_ui/process()
	. = ..()
	for (var/simple_ui in processing_uis)
		var/datum/simple_ui/UI = simple_ui
		UI.process()

/controller/simple_ui/proc/start_processing(var/datum/simple_ui/UI)
	src.processing_uis |= list(UI)

/controller/simple_ui/proc/stop_processing(var/datum/simple_ui/UI)
	src.processing_uis ^= list(UI)

/world/init_controllers(datum/scheduler/scheduler)
	. = ..()
	scheduler.add_controller(new /controller/simple_ui())

