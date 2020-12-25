
//! In Progress Game State
/datum/game_state/midgame 
	name = "Playing"
	
/datum/game_state/midgame/state_entry()
	. = ..()
	src.next_state_time = world.time + HOURS(2)
	src.next_state = new /datum/game_state/endgame()
