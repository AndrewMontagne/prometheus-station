
var/global/controller/game_loop/game_loop = null

/// The Game Loop Controller - This controls the overall game state and handles the gamemode logic
/controller/game_loop
	name = "Game"
	var/datum/gamemode/running_gamemode = null
	var/datum/game_state/state = null;

/controller/game_loop/New()
	if (!isnull(game_loop))
		CRASH("Initialising the game loop twice!")
	game_loop = src

	state = new /datum/game_state/pregame()

/controller/game_loop/proc/is_pre_game()
	return istype(src.state, /datum/game_state/pregame)

/controller/game_loop/proc/is_game_running()
	return !(src.is_pre_game() || src.is_game_over())

/controller/game_loop/proc/is_game_over()
	return istype(src.state, /datum/game_state/endgame)

/controller/game_loop/process()
	. = ..()
	if (!isnull(src.running_gamemode))
		src.running_gamemode.process()

	if (!isnull(src.state))
		if (!isnull(src.state.next_state_time) && world.time >= src.state.next_state_time)
			src.state.state_exit()
			var/oldstate = src.state
			src.state = src.running_gamemode.get_initial_state()
			if (!isnull(src.state))
				src.state.state_entry()
			del(oldstate)
