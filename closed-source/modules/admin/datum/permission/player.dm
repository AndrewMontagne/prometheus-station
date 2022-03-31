/datum/permission/player 
	name = "Playing"
	verbs = list(/datum/permission/player/verb/startgame)

/datum/permission/player/verb/startgame()
	set category = "Commands"
	set name = "Start Now"
	set hidden = FALSE

	if (GLOBALS.game_loop.is_pre_game())
		GLOBALS.game_loop.state.next_state_time = world.time
	else
		usr << "We are not in pregame!"
