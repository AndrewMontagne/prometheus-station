/**
Extended Roleplay

The "default" gamemode. There are no objectives, just play a normal shift.
**/
/datum/gamemode/extended
	name = "Extended"
	desc = "Just relax and enjoy the game!"

/datum/gamemode/extended/can_run()
	var/list/ready = game_loop.get_ready_players()
	return ready.len > 0

/datum/gamemode/extended/initialize()
	. = ..()
	return new /datum/game_state/midgame()
