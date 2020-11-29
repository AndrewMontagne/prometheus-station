var/global/datum/controller/game_controller/master_controller //Set in world.New()

datum/controller/game_controller
	var/processing = 1

	proc
		setup()
		setup_objects()
		process()

	setup()
		if(master_controller && (master_controller != src))
			del(src)
			//There can be only one master.

		setup_objects()

		emergency_shuttle = new /datum/shuttle_controller/emergency_shuttle()

		if(!ticker)
			ticker = new /datum/controller/gameticker()

		spawn
			ticker.pregame()

	setup_objects()
		world << "\red \b Initializing objects"
		sleep(-1)

		for(var/obj/object in world)
			object.initialize()

		world << "\red \b Initializations complete."


	process()

		if(!processing)
			return FALSE
		//world << "Processing"

		var/start_time = world.timeofday

		sun.calc_position()

		sleep(-1)

		for(var/mob/M in world)
			M.Life()

		sleep(-1)

		for(var/obj/machinery/machine in machines)
			machine.process()

		sleep(-1)
		sleep(1)

		for(var/obj/item/item in processing_items)
			item.process()
		for(var/datum/powernet/P in powernets)
			P.reset()

		sleep(-1)

		ticker.process()

		sleep(world.timeofday+10-start_time)

		spawn process()

		return TRUE
