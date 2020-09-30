/datum/permission/player 
	name = "Playing"
	verbs = list(/datum/permission/player/verb/startgame)

/datum/permission/player/verb/startgame()
	set category = "Commands"
	set name = "Start Now"
	set hidden = FALSE
	ticker.current_state = GAME_STATE_SETTING_UP
