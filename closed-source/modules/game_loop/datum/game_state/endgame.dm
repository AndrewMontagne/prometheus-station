
/// 
/datum/game_state/endgame 
	name = "Game Over"

/datum/game_state/endgame/state_exit()
	world.Reboot()
