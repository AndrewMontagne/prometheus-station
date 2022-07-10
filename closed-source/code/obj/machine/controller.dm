
/controller/machines
	name = "Machinery"

/controller/machines/process()
	. = ..()
	if (!GLOBALS.game_loop.is_game_running())
		return

	var/list/obj/machine/shuffled_machines = list()
	for (var/i in GLOBALS.all_machines)
		shuffled_machines.Add(i)
	shuffle_list(shuffled_machines)
	
	for (var/i in shuffled_machines)
		var/obj/machine/M = i
		M.process()

/world/init_controllers(datum/scheduler/scheduler)
	. = ..()
	scheduler.add_controller(new /controller/machines())
