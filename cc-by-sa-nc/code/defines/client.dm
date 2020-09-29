/client
	var/listen_ooc = 1
	var/move_delay = 1
	var/moving = null
	var/vote = null
	var/showvote = null
	var/deadchat = 0.0
	var/changes = 0
	var/canplaysound = 1
	var/ambience_playing = null
	var/no_ambi = 0
	var/area = null
	var/played = 0
	var/fakekey = null
	fps = 60

	// comment out the line below when debugging locally to enable the options & messages menu
	control_freak = 1
