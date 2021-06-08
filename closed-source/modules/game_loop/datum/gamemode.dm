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
	if (!game_loop || !game_loop.is_pre_game())
		throw EXCEPTION("Game loop is in an invalid state for gamemode initialisation!")

	for (var/mob/lobby/new_player in world)
		if (!new_player.ready || !new_player.client)
			continue
		spawn_player(new_player)

/// Spawns a given player
/datum/gamemode/proc/spawn_player(mob/lobby/new_player)

	for (var/obj/spawnpoint/spawnpoint in world)
		if (locate(/mob/player) in spawnpoint.loc)
			continue
		else
			var/mob/player/player_mob = new(spawnpoint.loc)
			new_player.client.change_mob(player_mob)
			del(new_player)
