
/controller/machines
	name = "Machinery"

/controller/machines/process()
	. = ..()
	if (!GLOBALS.game_loop.is_game_running())
		return

	for (var/i in GLOBALS.all_machines)
		var/obj/machine/M = i
		M.process()

/world/init_controllers(datum/scheduler/scheduler)
	. = ..()
	scheduler.add_controller(new /controller/machines())
