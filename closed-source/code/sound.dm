
/proc/play_sound(var/filename, atom/loc, var/range = 12, var/volume = 100)
	var/list/mob/can_hear = null
	if (istype(loc, /mob))
		can_hear = list(loc)
	else
		can_hear = hearers(range, loc)

	for (var/hearer in can_hear)
		var/mob/M = hearer
		if (!M.client)
			continue
		
		var/distance = sqrt(((loc.x - M.x) ** 2) + ((loc.y - M.y) ** 2))
		var/mul = (range - distance) / range
		LOG_TRACE("[mul]")

		var/sound/S = sound(filename)
		S.volume = volume * mul
		S.frequency = rand(8,12) / 10

		M.client << S
