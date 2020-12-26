
/**
Game State Base Class

This class handles game state logic, and is intended to be used by "phases" of
gamemodes to encapsulate logic into those phases alone.

There are three builtin states for pregame, midgame and endgame.
**/
/datum/game_state/
	/// The world.time when the next state ticks over
	var/next_state_time = null
	/// The next state
	var/datum/game_state/next_state = null
	/// The name of this state
	var/name = ""

/// Called by the game loop controller after processing the gamemode
/datum/game_state/proc/process()
	return

/// Returns the time left in this state in seconds, or null if indefinite
/datum/game_state/proc/seconds_left()
	if (isnull(src.next_state_time))
		return null
	else
		return round(src.next_state_time - world.time)

/// Fired when we enter this state
/datum/game_state/proc/state_entry()
	return

/// Fired when we exit this state
/datum/game_state/proc/state_exit()
	return

