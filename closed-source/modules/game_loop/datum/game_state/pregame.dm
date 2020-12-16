
/// 
/datum/game_state/pregame 
	name = "Pre-game"
	

/datum/game_state/pregame/New()
	. = ..()

/datum/game_state/pregame/state_exit()
	. = ..()
	game_loop.running_gamemode = pick(src.available_gamemodes())
	
/// Lists the available gamemodes to play
/datum/game_state/pregame/proc/available_gamemodes()
	var/list/gamemode_paths = typesof(/datum/gamemode)
	var/list/gamemodes = list()

	for (var/gamemode_path in gamemode_paths)
		var/datum/gamemode/gamemode = new gamemode_path()
		if (!gamemode.can_run())
			del(gamemode)
			continue
		gamemodes.Add(gamemode)
	
	return gamemodes
