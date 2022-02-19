
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

		var/sound/S = sound(filename)
		S.falloff = 1
		S.x = (loc.x - M.x)
		S.y = (loc.y - M.y)
		S.volume = volume
		S.frequency = rand(8,12) / 10
		var/area/A = M.find_turf():loc
		S.environment = A.sound_environment

		M.client << S
