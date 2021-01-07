/mob/new_player
	anchored = 1

	var/datum/preferences/preferences
	var/ready = 0

	invisibility = 101

	density = 0
	stat = 2
	canmove = 0
	sight = BLIND
	var/global/obj/screen/splash/splashscreen
	var/global/lobby_music_track = pick('closed-source/music/robocop.ogg','closed-source/music/tintin.ogg')

	anchored = 1	//  don't get pushed around

/mob/new_player/Login()
	..()

	x = 50
	y = 50
	z = 2

	if(isnull(splashscreen))
		splashscreen = new /obj/screen/splash()

	src << sound(lobby_music_track, repeat = 0, wait = 0, channel=1337)

	client.screen += splashscreen
	client.screen += base_hud()

	if(!preferences)
		preferences = new

	if(!mind)
		mind = new
		mind.key = key
		mind.current = src

	new_player_panel()

	var/list/watch_locations = list()
	for(var/obj/landmark/landmark in world)
		if(landmark.tag == "landmark*new_player")
			watch_locations += landmark.loc

	if(watch_locations.len>0)
		loc = pick(watch_locations)

	if(!preferences.savefile_load(src, 0))
		preferences.ShowChoices(src)


/mob/new_player/Logout()
	ready = 0

	if(!isnull(client))
		client.screen -= splashscreen

	..()
	return

/mob/new_player/verb/new_player_panel()
	set src = usr

	if(!isnull(ticker) && ticker.current_state > GAME_STATE_PREGAME)
		reconfigure_window_to_join()
	else
		winset(src, "loginwindow.loginbutton_ready", "border=line; text=\"Ready Up\"; background-color=#00dc00; focus=false")
	
	winset(src, "loginwindow", "is-visible=true;")
	src << browse_rsc('cc-by-sa-nc/icons/postcardsmall.png')
	src << browse("<html><body>[join_motd]</body></html>", "window=loginwindow")

/mob/new_player/proc/reconfigure_window_to_join()
	ready = 0
	winset(src, "loginwindow.loginbutton_ready", "border=line; text=\"Join Round\"; background-color=#00bbdc; focus=false")

/mob/new_player/verb/toggle_ready()
	set name = "toggleready"

	if(!ticker || ticker.current_state <= GAME_STATE_PREGAME)
		if (!usr.client.has_permission("BAN"))
			src << "You are not authorized to enter the game."
			return

		if(!ready)
			ready = 1
			winset(src, "loginwindow.loginbutton_ready", "border=sunken; text=\"Cancel\"; background-color=#dc0000; focus=false")
		else
			ready = 0
			winset(src, "loginwindow.loginbutton_ready", "border=line; text=\"Ready Up\"; background-color=#00dc00; focus=false")
	else
		LateChoices()


/mob/new_player/verb/show_preferences()
	set name = "showpreferences"
	preferences.ShowChoices(src)

/mob/new_player/verb/toggle_observe()
	set name = "toggleobserve"

	if (!usr.client.has_permission("BAN"))
		src << "You are not authorized to enter the game."
		return

	if(alert(src,"Are you sure you wish to observe? You will not be able to play this round!","Player Setup","Yes","No") == "Yes")
		var/mob/dead/observer/observer = new()

		close_spawn_windows()
		var/obj/O = locate("landmark*Observer-Start")
		src << "\blue Now teleporting."
		observer.loc = O.loc
		observer.key = key
		if(preferences.be_random_name)
			preferences.randomize_name()
		observer.name = preferences.real_name
		observer.real_name = observer.name

		del(src)

/mob/new_player/Stat()
	..()

	if(ticker)
		switch(ticker.current_state)
			if(GAME_STATE_SETTING_UP)
				winset(src, "login_label", "text=\"Please wait...\"")
			if(GAME_STATE_PREGAME)
				var/secs = ticker.pregame_timeleft - 2
				var/mins = (secs - (secs % 60)) / 60
				secs %= 60
				var/time = "in"
				if (mins > 0)
					time += " [mins] min"
				time += " [secs] secs"
				if (ticker.pregame_timeleft <= 1)
					time = "shortly..."
				winset(src, "login_label", "text=\"Round starts [time]\"")
			if(GAME_STATE_PLAYING)
				winset(src, "login_label", "text=\"Welcome to [world.name]!\"")

/mob/new_player/Topic(href, href_list[])

	if(href_list["SelectedJob"])
		if (!usr.client.has_permission("BAN"))
			src << "You are not authorized to enter the game."
			return

		if (!enter_allowed)
			usr << "\blue There is an administrative lock on entering the game!"
			return

		switch(href_list["SelectedJob"])
			if ("1")
				AttemptLateSpawn("Captain", captainMax)
			if ("2")
				AttemptLateSpawn("Head of Security", hosMax)
			if ("3")
				AttemptLateSpawn("Head of Personnel", hopMax)
			if ("4")
				AttemptLateSpawn("Station Engineer", engineerMax)
			if ("5")
				AttemptLateSpawn("Barman", barmanMax)
			if ("6")
				AttemptLateSpawn("Scientist", scientistMax)
			if ("7")
				AttemptLateSpawn("Chemist", chemistMax)
			if ("8")
				AttemptLateSpawn("Geneticist", geneticistMax)
			if ("9")
				AttemptLateSpawn("Security Officer", securityMax)
			if ("10")
				AttemptLateSpawn("Medical Doctor", doctorMax)
			if ("11")
				AttemptLateSpawn("Atmospheric Technician", atmosMax)
			if ("12")
				AttemptLateSpawn("Detective", detectiveMax)
			if ("13")
				AttemptLateSpawn("Chaplain", chaplainMax)
			if ("14")
				AttemptLateSpawn("Janitor", janitorMax)
			if ("15")
				AttemptLateSpawn("Clown", clownMax)
			if ("16")
				AttemptLateSpawn("Chef", chefMax)
			if ("17")
				AttemptLateSpawn("Roboticist", roboticsMax)
			if ("18")
				AttemptLateSpawn("Assistant", 10000)
			if ("19")
				AttemptLateSpawn("Quartermaster", cargoMax)
			if ("20")
				AttemptLateSpawn("Research Director", directorMax)
			if ("21")
				AttemptLateSpawn("Chief Engineer", chiefMax)
//				if ("22")
//					AttemptLateSpawn("Hydroponist", hydroponicsMax)

	if(!ready && href_list["preferences"])
		preferences.process_link(src, href_list)
	else if(!href_list["late_join"])
		new_player_panel()

/mob/new_player/proc/IsJobAvailable(rank, maxAllowed)
	if(countJob(rank) < maxAllowed)
		return TRUE
	else
		return FALSE

/mob/new_player/proc/AttemptLateSpawn(rank, maxAllowed)
	if(IsJobAvailable(rank, maxAllowed))
		var/mob/living/carbon/human/character = create_character()

		character.Equip_Rank(rank, joined_late=1)

		//add to manifest
		for(var/datum/data/record/t in data_core.general)
			if((t.fields["name"] == character.real_name) && (t.fields["rank"] == "Unassigned"))
				t.fields["rank"] = rank

		if (ticker.current_state == GAME_STATE_PLAYING)
			for (var/mob/living/silicon/ai/A in world)
				if (!A.stat)
					A.say("[character.real_name] has signed up as [rank].")

		var/starting_loc = pick(latejoin)
		character.loc = starting_loc
		del(src)

	else
		src << alert("[rank] is not available. Please try another.")

// This fxn creates positions for assistants based on existing positions. This could be more elgant.
/mob/new_player/proc/LateChoices()
	var/dat = "<html><body>"
	dat += "Choose from the following open positions:<br>"
	if (IsJobAvailable("Captain",captainMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=1'>Captain</a><br>"

	if (IsJobAvailable("Head of Security",hosMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=2'>Head of Security</a><br>"

	if (IsJobAvailable("Head of Personnel",hopMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=3'>Head of Personnel</a><br>"

	if (IsJobAvailable("Research Director",directorMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=20'>Research Director</a><br>"

	if (IsJobAvailable("Chief Engineer",chiefMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=21'>Chief Engineer</a><br>"

	if (IsJobAvailable("Station Engineer",engineerMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=4'>Station Engineer</a><br>"

	if (IsJobAvailable("Barman",barmanMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=5'>Barman</a><br>"

	if (IsJobAvailable("Scientist",scientistMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=6'>Scientist</a><br>"

	if (IsJobAvailable("Chemist",chemistMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=7'>Chemist</a><br>"

	if (IsJobAvailable("Geneticist",geneticistMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=8'>Geneticist</a><br>"

	if (IsJobAvailable("Security Officer",securityMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=9'>Security Officer</a><br>"

	if (IsJobAvailable("Medical Doctor",doctorMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=10'>Medical Doctor</a><br>"

	if (IsJobAvailable("Atmospheric Technician",atmosMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=11'>Atmospheric Technician</a><br>"

	if (IsJobAvailable("Detective",detectiveMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=12'>Detective</a><br>"

	if (IsJobAvailable("Chaplain",chaplainMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=13'>Chaplain</a><br>"

	if (IsJobAvailable("Janitor",janitorMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=14'>Janitor</a><br>"

	if (IsJobAvailable("Clown",clownMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=15'>Clown</a><br>"

	if (IsJobAvailable("Chef",chefMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=16'>Chef</a><br>"

	if (IsJobAvailable("Roboticist",roboticsMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=17'>Roboticist</a><br>"

	if (IsJobAvailable("Quartermaster",cargoMax))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=19'>Quartermaster</a><br>"
		
	dat += "<a href='byond://?src=\ref[src];SelectedJob=18'>Assistant</a><br>"

	src << browse(dat, "window=latechoices;size=300x640;can_close=0")

/mob/new_player/proc/create_character()
	var/mob/living/carbon/human/new_character = new(src.loc)

	close_spawn_windows()

	preferences.copy_to(new_character)

	mind.transfer_to(new_character)


	return new_character

/mob/new_player/Move()
	return FALSE


/mob/new_player/proc/close_spawn_windows()
	src << browse(null, "window=latechoices") //closes late choices window
	src << browse(null, "window=playersetup") //closes the player setup window
	winset(src, "loginwindow", "is-visible=false;")
	src << sound(null, repeat = 0, wait = 0, channel = 1337)
