/datum/game_mode
	var/name = "invalid"
	var/config_tag = null
	var/votable = 1
	var/probability = 1

/datum/game_mode/proc/announce()
	world << "<B>[src] did not define announce()</B>"

/datum/game_mode/proc/pre_setup()
	return 1

/datum/game_mode/proc/post_setup()

/datum/game_mode/proc/process()

/datum/game_mode/proc/check_finished()
	if(emergency_shuttle.location==2)
		return TRUE
	return FALSE

/datum/game_mode/proc/declare_completion()
	return FALSE

/datum/game_mode/proc/check_win()

/datum/game_mode/proc/send_intercept()
