
/**
Extended roleplay. The "default" gamemode.
**/
/datum/gamemode/extended
	name = "Extended"
	desc = "Just relax and enjoy the game!"

/datum/gamemode/can_run()
	return TRUE

/datum/gamemode/get_initial_state()
	return new /datum/game_state/midgame()
