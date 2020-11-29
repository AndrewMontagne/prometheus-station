#define LOG_ERROR(X)   world.logger(X, "ERROR", "31")
#define LOG_WARNING(X) world.logger(X, "WARNI", "33")
#define LOG_SYSTEM(X)  world.logger(X, "SYSTM", "32")
#define LOG_INFO(X)    world.logger(X, "INFOR", "34")
#define LOG_DEBUG(X)   world.logger(X, "DEBUG", "35")
#define LOG_TRACE(X)   world.logger(X, "TRACE", "36")

/world/
	mob = /mob/new_player
	turf = /turf/space
	area = /area/space
	view = "19x17"

/world/Error(exception/E, datum/src)
	if (!istype(E))
		return ..()
	world.logger("[E.name] @ [E.file]:[E.line]")

/world/proc/logger(var/message, level="?????", ansicolor="0")
	var/timestamp = time2text(world.timeofday, "hh:mm:ss")
	var/ansi_level = "\u001b\[[ansicolor]m[level]\u001b\[0m"
	world.log << "[timestamp] \[[ansi_level]\] [message]"

/world/New()
	..()
	LOG_SYSTEM("Initialising BYOND Extensions...")
	extools_initialize()
	tffi_initialize()
	debugger_initialize(FALSE)
	rustg_url_encode("") // Check for rustg's presence

	LOG_SYSTEM("Loading Configuration...")
	src.load_configuration()
	if (config && config.server_name != null && config.server_suffix && world.port > 0)
		config.server_name += " #[(world.port % 1000) / 100]"
	src.load_mode()
	src.load_motd()
	src.load_rules()
	src.load_admins()
	src.update_status()

	LOG_SYSTEM("Initialising Lighting...")
	lighting_start_process()
	create_all_lighting_overlays()

	LOG_SYSTEM("Initialising Master Controller...")
	master_controller = new /datum/controller/game_controller()
	spawn(-1) master_controller.setup()

	LOG_SYSTEM("Initialising Powernets...")
	makepowernets()

	LOG_SYSTEM("Initialisation Completed!")
