/**
Pregame Game State

This is the default game state and cannot be changed. The next state is undefined by default, and is set by the gamemode before it exits.
**/
/datum/game_state/pregame 
	name = "Pre-game"

/datum/game_state/pregame/proc/round_start_time()
	return world.time + MINUTES(3)
	
/datum/game_state/pregame/state_entry()
	. = ..()

/datum/game_state/pregame/state_exit()
	. = ..()
	var/list/datum/gamemode/candidates = src.available_gamemodes()
	GLOBALS.game_loop.running_gamemode = candidates.len > 0 ? pick(candidates) : null

	try
		if (isnull(GLOBALS.game_loop.running_gamemode))
			throw EXCEPTION("No gamemode candidates!")
		src.next_state = GLOBALS.game_loop.running_gamemode.initialize()
		for (var/mob/lobby/L in world)
			if (isnull(L.client))
				del(L)
				continue
			winset(L, "loginwindow.loginbutton_ready", "border=line; text=\"Join Round\"; background-color=#00bbdc; focus=false")
			winset(L, "login_label", "text=\"Welcome to [world.name]!\"")
	catch (var/exception/E)
		src.next_state = new /datum/game_state/pregame()
		if (isnull(GLOBALS.game_loop.running_gamemode))
			LOG_ERROR("No candidate gamemodes!")
		else
			LOG_ERROR("Could not initialise gamemode [GLOBALS.game_loop.running_gamemode.type]: [E.name] [E.file]:[E.name] [E.desc]")
		world << "Could not start the game, restarting lobby..."
		return

/datum/game_state/pregame/process()
	var/n = 0
	for (var/client/C)
		n++
	if (n == 0 && src.next_state_time != null)
		src.next_state_time = null
		spawn(SECONDS(1)) world.sleep_offline = TRUE
	else if (n != 0  && src.next_state_time == null)
		src.next_state_time = src.round_start_time()
		world.sleep_offline = FALSE
	for (var/mob/lobby/L in world)
		L.update_login_window()
	
/// Lists the available gamemodes to play
/datum/game_state/pregame/proc/available_gamemodes()
	PRIVATE_PROC(TRUE)
	var/list/gamemode_paths = typesof(/datum/gamemode)
	var/list/gamemodes = list()

	for (var/gamemode_path in gamemode_paths)
		var/datum/gamemode/gamemode = new gamemode_path()
		if (!gamemode.can_run())
			del(gamemode)
			continue
		gamemodes.Add(gamemode)
	
	return gamemodes

/// Gets the list of pregame mobs that are currently readied up
/datum/game_state/pregame/proc/get_ready_players()
	var/list/mob/lobby/ready = list()
	for (var/mob/lobby/L in world)
		if (isnull(L.client))
			del(L)
			continue
		if (L.ready)
			ready.Add(L)
	return ready
