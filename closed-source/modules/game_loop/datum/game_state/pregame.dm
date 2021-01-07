/**
Pregame Game State

This is the default game state and cannot be changed. The next state is undefined by default, and is set by the gamemode before it exits.
**/
/datum/game_state/pregame 
	name = "Pre-game"
	
/datum/game_state/pregame/state_entry()
	. = ..()
	src.next_state_time = world.time + MINUTES(1)

/datum/game_state/pregame/state_exit()
	. = ..()
	game_loop.running_gamemode = pick(src.available_gamemodes())
	src.next_state = game_loop.running_gamemode.get_initial_state()

/datum/game_state/pregame/process()
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
