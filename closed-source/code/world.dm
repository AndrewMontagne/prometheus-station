/world/
	mob = /mob/new_player
	turf = /turf/space
	area = /area/space
	view = "19x17"

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
	LOG_SYSTEM("Initialising BYOND Extensions...")
	extools_initialize()
	tffi_initialize()
	debugger_initialize(FALSE)
	rustg_url_encode("") // Check for rustg's presence

	LOG_SYSTEM("Initialising Lighting...")
	lighting_start_process()
	create_all_lighting_overlays()

	LOG_SYSTEM("Initialising Ticker...")
	emergency_shuttle = new /datum/shuttle_controller/emergency_shuttle()
	if (!ticker)
		ticker = new /datum/controller/gameticker()
		spawn()
			ticker.pregame()

	LOG_SYSTEM("Startup Complete!")
	world.sleep_offline = TRUE

/world/Del()
	. = ..()
	LOG_SYSTEM("Shutting down...")
