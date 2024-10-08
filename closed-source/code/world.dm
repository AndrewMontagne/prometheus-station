/world/
	mob = /mob/lobby
	turf = /turf/space
	area = /area/space
	view = "19x17"
	loop_checks = TRUE
	fps = FRAMES_PER_SECOND
	
/world/Error(exception/E, datum/src)
	if (!istype(E))
		return ..()
	LOG_ERROR("[E.name] @ [E.file]:[E.line]")
	world.log << E.desc

/// World logging procedure
/world/proc/logger(var/message, level="?????", ansicolor="0")
	var/timestamp = time2text(world.timeofday, "hh:mm:ss")
	var/ansi_level = "\u001b\[[ansicolor]m[level]\u001b\[0m"
	world.log << "[timestamp] \[[ansi_level]\] [message]"

/world/New()
	. = ..()

	var/startup_profile = file2text("config/startup_profile")
	if (findtext(startup_profile, "TRUE") != 0)
		LOG_ADMIN("NO CKEY", "Startup Profiling Enabled!!!")
		world.Profile(PROFILE_START | PROFILE_AVERAGE, "json")
		
	world.sleep_offline = FALSE
	LOG_SYSTEM("Initialising BYOND Extensions...")

	rustg_url_encode("") // Check for rustg's presence
	var/debug_server = world.GetConfig("env", "AUXTOOLS_DEBUG")
	if (debug_server)
		LOG_SYSTEM("Debugging enabled! Waiting 3 seconds to let you attach a debugger")
		debug_initialise()
		for(var/i=0, i < 6, i++)
			sleep(SECONDS(0.5))

	LOG_SYSTEM("Loading Map...")

	var/datum/map_loader/loader = new(TRUE)
	loader.load_map("/app/closed-source/maps/newmap.dmm")
	loader.write_map(1, 1, 2)
	loader.init_atoms()

	for (var/turf/space/S in world.contents)
		if (S.needs_init)
			S.Initialise()

	LOG_SYSTEM("Initialising Controllers...")

	GLOBALS.scheduler = new /datum/scheduler()
	src.init_controllers(GLOBALS.scheduler)

	//GLOBALS.scheduler.add_controller(new /controller/stress("0000", PRIORITY_LOW))

	if (startup_profile)
		var/json_str = world.Profile(PROFILE_STOP | PROFILE_AVERAGE, "json")
		var/filename = "data/profile_startup.json"
		text2file(json_str, filename)
		world.Profile(PROFILE_CLEAR)

	LOG_SYSTEM("Performing First Tick")

	GLOBALS.scheduler.tick()

	LOG_SYSTEM("Startup Complete!")
	world.sleep_offline = TRUE

/// Overrided in each controller definition, this allows us to inject our controller dependencies.
/world/proc/init_controllers(datum/scheduler/scheduler)
	SHOULD_CALL_PARENT(TRUE)
	return

/world/Del()
	. = ..()
	LOG_SYSTEM("Shutting down...")
