
/**
End of game state. Roll the credits, shut down everything when done.
**/
/datum/game_state/endgame 
	name = "Game Over"

/datum/game_state/endgame/state_entry()
	src.next_state_time = world.time + MINUTES(2)

/datum/game_state/endgame/state_exit()
	. = ..()
	world.Reboot()
