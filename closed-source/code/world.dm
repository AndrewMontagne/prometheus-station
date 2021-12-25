/world/
	mob = /mob/lobby
	turf = /turf/space
	area = /area/space
	view = "19x17"
	loop_checks = TRUE
	fps = 10
	
/world/Error(exception/E, datum/src)
	if (!istype(E))
		return ..()
	LOG_ERROR("[E.name] @ [E.file]:[E.line]")
	world.log << E.desc

/world/proc/logger(var/message, level="?????", ansicolor="0")
	var/timestamp = time2text(world.timeofday, "hh:mm:ss")
	var/ansi_level = "\u001b\[[ansicolor]m[level]\u001b\[0m"
	world.log << "[timestamp] \[[ansi_level]\] [message]"

/world/New()
	. = ..()

	var/startup_profile = file2text("config/startup_profile")
	if (findtext(startup_profile, "TRUE") != 0)
		LOG_ADMIN("Startup Profiling Enabled!!!")
		world.Profile(PROFILE_START | PROFILE_AVERAGE, "json")

	world.sleep_offline = FALSE
	LOG_SYSTEM("Initialising BYOND Extensions...")
	rustg_url_encode("") // Check for rustg's presence

	LOG_SYSTEM("Loading Map...")

	var/datum/map_loader/loader = new(TRUE)
	loader.load_map("/app/closed-source/maps/newmap.dmm")
	loader.write_map(1, 1, 1)
	loader.init_atoms()

	LOG_SYSTEM("Initialising Controllers...")

	scheduler = new /datum/scheduler()

	src.init_controllers(scheduler)

	//C = new /controller/stress("0000", PRIORITY_LOW)
	//scheduler.add_controller(C)

	if (startup_profile)
		var/json_str = world.Profile(PROFILE_STOP | PROFILE_AVERAGE, "json")
		var/filename = "data/profile_startup.json"
		text2file(json_str, filename)
		world.Profile(PROFILE_CLEAR)

	LOG_SYSTEM("Startup Complete!")
	world.sleep_offline = TRUE

/world/proc/init_controllers(datum/scheduler/scheduler)
	SHOULD_CALL_PARENT(TRUE)
	return

/world/Del()
	. = ..()
	LOG_SYSTEM("Shutting down...")
