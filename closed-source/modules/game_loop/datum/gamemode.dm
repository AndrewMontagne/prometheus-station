/**
Gamemode Base Class

This class encapsulates gamemode functionality
**/
/datum/gamemode
	/// The minimum number of players for this gamemode
	var/minimum_players = null
	/// The maximum number of players for this gamemode
	var/maximum_players = null
	/// The human-readable name of this gamemode
	var/name = ""
	/// A description of this gamemode
	var/desc = ""

/// Returns whether this gamemode's prerequisites have been met
/datum/gamemode/proc/can_run()
	return FALSE

/// Called by the game loop controller before we process the game state
/datum/gamemode/proc/process()
	return

/// Initialises the gamemode and returns the initial state for this gamemode
/datum/gamemode/proc/initialize()
	if (!GLOBALS.game_loop || !GLOBALS.game_loop.is_pre_game())
		throw EXCEPTION("Game loop is in an invalid state for gamemode initialisation!")

	for (var/mob/lobby/new_player in world)
		if (!new_player.ready || !new_player.client)
			continue
		spawn_player(new_player)

/// Spawns a given player
/datum/gamemode/proc/spawn_player(mob/lobby/new_player)

	var/list/obj/spawnpoint/spawns = list()
	for (var/obj/spawnpoint/S in world)
		if (locate(/mob/player) in S.loc)
			continue
		spawns.Add(S)
	
	var/obj/spawnpoint/S = pick(spawns)
	var/mob/player/player_mob = new(S.loc)
	new_player.client.change_mob(player_mob)
	del(new_player)
