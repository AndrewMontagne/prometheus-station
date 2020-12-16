
///
/datum/gamemode
	var/minimum_players = null
	var/maximum_players = null
	var/name = ""
	var/desc = ""

/datum/gamemode/proc/can_run()
	return FALSE

/datum/gamemode/proc/process()
	return

/datum/gamemode/proc/get_initial_state()
	CRASH("/datum/gamemode/proc/get_initial_state() not implemented!")

