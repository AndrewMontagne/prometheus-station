var/global/datum/controller/gameticker/ticker

#define GAME_STATE_PREGAME		1
#define GAME_STATE_SETTING_UP	2
#define GAME_STATE_PLAYING		3
#define GAME_STATE_FINISHED		4

/datum/controller/gameticker
	var/current_state = GAME_STATE_PREGAME

	var/hide_mode = 0
	var/event_time = null
	var/event = 0

	var/list/datum/mind/minds = list()

	var/pregame_timeleft = 0

/datum/controller/gameticker/proc/pregame()
	set background = 1

	pregame_timeleft = 120
	world << "<B><FONT color='blue'>Welcome to the pre-game lobby!</FONT></B>"
	world << "Please, setup your character and select ready. Game will start in [pregame_timeleft] seconds"

	while(current_state == GAME_STATE_PREGAME)
		sleep(10)
		pregame_timeleft--

		if(pregame_timeleft <= 0)
			current_state = GAME_STATE_SETTING_UP

	spawn setup()

/datum/controller/gameticker/proc/setup()

	LOG_SYSTEM("Starting round with gamemode: [master_mode]")

	//Distribute jobs
	distribute_jobs()

	//Create player characters and transfer them
	create_characters()

	add_minds()


	//Equip characters
	equip_characters()

	data_core.manifest()


	current_state = GAME_STATE_PLAYING
	spawn(0)
		for(var/mob/new_player/P in world)
			P.reconfigure_window_to_join()

		//Start master_controller.process()
		LOG_SYSTEM("Round started")
		world << "<FONT color='blue'><B>Enjoy the game!</B></FONT>"

/datum/controller/gameticker
	proc/distribute_jobs()
		DivideOccupations()

	proc/create_characters()
		for(var/mob/new_player/player in world)
			if(player.ready)
				if(player.mind && player.mind.assigned_role=="AI")
					player.close_spawn_windows()
					player.AIize()
				else if(player.mind)
					player.create_character()
					del(player)
	proc/add_minds()
		for(var/mob/living/carbon/human/player in world)
			if(player.mind)
				ticker.minds += player.mind

	proc/equip_characters()
		for(var/mob/living/carbon/human/player in world)
			if(player.mind && player.mind.assigned_role)
				if(player.mind.assigned_role != "MODE")
					player.Equip_Rank(player.mind.assigned_role)

	proc/process()
		if(current_state != GAME_STATE_PLAYING)
			return FALSE

		emergency_shuttle.process()

		return TRUE

/datum/controller/gameticker/proc/declare_completion()

	for (var/mob/living/silicon/ai/aiPlayer in world)
		if (aiPlayer.stat != 2)
			world << "<b>The AI's laws at the end of the game were:</b>"
		else
			world << "<b>The AI's laws when it was deactivated were:</b>"

		aiPlayer.show_laws(1)

	return TRUE
