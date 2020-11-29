/mob/living/carbon/human/death(gibbed)
	if(src.stat == 2)
		return
	if(src.healths)
		src.healths.icon_state = "health5"
	src.stat = 2
	src.dizziness = 0
	src.jitteriness = 0

	if (!gibbed)
		emote("deathgasp") //let the world KNOW WE ARE DEAD

		src.canmove = 0
		if(src.client)
			src.blind.layer = 0
		src.lying = 1
		var/h = src.hand
		src.hand = 0
		drop_item()
		src.hand = 1
		drop_item()
		src.hand = h
		if (src.client)
			spawn(10)
				if(src.client && src.stat == 2)
					src.verbs += /mob/proc/ghostize

	var/tod = time2text(world.realtime,"hh:mm:ss") //weasellos time of death patch
	if(mind)
		mind.store_memory("Time of death: [tod]", 0)
	//src.icon_state = "dead"

	ticker.mode.check_win()

	/*
		if (ticker.mode.name == "Corporate Restructuring" && ticker.target != src)
			src.unlock_medal("Expendable", 1)

		//For restructuring
		if (ticker.mode.name == "Corporate Restructuring" || ticker.mode.name == "revolution")
			ticker.check_win()

		if (ticker.mode.name == "wizard" && src == ticker.killer)
			world << "<FONT size = 3><B>Research Station Victory</B></FONT>"
			world << "<B>The Wizard has been killed!</B> The wizards federation has been taught an important lesson."
			ticker.processing = 0
			sleep(100)
			world << "\blue Rebooting due to end of game"
			world.Reboot()
	*/ //TODO: FIX

	var/cancel
	for (var/mob/M in world)
		if (M.client && !M.stat)
			cancel = 1
			break

	if (!cancel && !abandon_allowed)
		spawn (50)
			cancel = 0
			for (var/mob/M in world)
				if (M.client && !M.stat)
					cancel = 1
					break

			if (!cancel && !abandon_allowed)
				world << "<B>Everyone is dead! Resetting in 30 seconds!</B>"

				spawn (300)
					log_game("Rebooting because of no live players")
					world.Reboot()

	return ..(gibbed)
