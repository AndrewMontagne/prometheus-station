
/controller/machines
	

/controller/machines/process()
	. = ..()
	if (!game_loop.is_game_running())
		return

	for (var/i in global_all_machines)
		var/obj/machine/M = i
		M.process()

/world/init_controllers(datum/scheduler/scheduler)
	. = ..()
	scheduler.add_controller(new /controller/machines())
