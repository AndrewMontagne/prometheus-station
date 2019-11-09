/proc/playsound(var/atom/source, soundin, vol as num, vary, range as num)
	//Frequency stuff only works with 45kbps oggs.

	switch(soundin)
		if ("shatter") soundin = pick('cc-by-sa-nc/sound/effects/Glassbr1.ogg','cc-by-sa-nc/sound/effects/Glassbr2.ogg','cc-by-sa-nc/sound/effects/Glassbr3.ogg')
		if ("explosion") soundin = pick('cc-by-sa-nc/sound/effects/Explosion1.ogg','cc-by-sa-nc/sound/effects/Explosion2.ogg')
		if ("sparks") soundin = pick('cc-by-sa-nc/sound/effects/sparks1.ogg','cc-by-sa-nc/sound/effects/sparks2.ogg','cc-by-sa-nc/sound/effects/sparks3.ogg','cc-by-sa-nc/sound/effects/sparks4.ogg')
		if ("rustle") soundin = pick('cc-by-sa-nc/sound/misc/rustle1.ogg','cc-by-sa-nc/sound/misc/rustle2.ogg','cc-by-sa-nc/sound/misc/rustle3.ogg','cc-by-sa-nc/sound/misc/rustle4.ogg','cc-by-sa-nc/sound/misc/rustle5.ogg')
		if ("punch") soundin = pick('cc-by-sa-nc/sound/weapons/punch1.ogg','cc-by-sa-nc/sound/weapons/punch2.ogg','cc-by-sa-nc/sound/weapons/punch3.ogg','cc-by-sa-nc/sound/weapons/punch4.ogg')
		if ("clownstep") soundin = pick('cc-by-sa-nc/sound/misc/clownstep1.ogg','cc-by-sa-nc/sound/misc/clownstep2.ogg')
		if ("swing_hit") soundin = pick('cc-by-sa-nc/sound/weapons/genhit1.ogg', 'cc-by-sa-nc/sound/weapons/genhit2.ogg', 'cc-by-sa-nc/sound/weapons/genhit3.ogg')

	var/sound/S = sound(soundin)
	S.wait = 0 //No queue
	S.channel = 0 //Any channel

	range += 15
	
	if (vary)
		S.frequency = rand(32000, 55000)
	for (var/mob/M in viewers(range, source))
		if (M.client)
			var/dx = source.x - M.x
			var/dy = source.y - M.y
			var/dist = sqrt((abs(dx) ** 2) + (abs(dy) ** 2))
			S.pan = max(-100, min(100, dx/8.0 * 100))
			S.volume = vol * (1 - (dist / range))
			M << S

/mob/proc/playsound_local(var/atom/source, soundin, vol as num, vary, extrarange as num)
	if(!src.client)
		return
	switch(soundin)
		if ("shatter") soundin = pick('cc-by-sa-nc/sound/effects/Glassbr1.ogg','cc-by-sa-nc/sound/effects/Glassbr2.ogg','cc-by-sa-nc/sound/effects/Glassbr3.ogg')
		if ("explosion") soundin = pick('cc-by-sa-nc/sound/effects/Explosion1.ogg','cc-by-sa-nc/sound/effects/Explosion2.ogg')
		if ("sparks") soundin = pick('cc-by-sa-nc/sound/effects/sparks1.ogg','cc-by-sa-nc/sound/effects/sparks2.ogg','cc-by-sa-nc/sound/effects/sparks3.ogg','cc-by-sa-nc/sound/effects/sparks4.ogg')
		if ("rustle") soundin = pick('cc-by-sa-nc/sound/misc/rustle1.ogg','cc-by-sa-nc/sound/misc/rustle2.ogg','cc-by-sa-nc/sound/misc/rustle3.ogg','cc-by-sa-nc/sound/misc/rustle4.ogg','cc-by-sa-nc/sound/misc/rustle5.ogg')
		if ("punch") soundin = pick('cc-by-sa-nc/sound/weapons/punch1.ogg','cc-by-sa-nc/sound/weapons/punch2.ogg','cc-by-sa-nc/sound/weapons/punch3.ogg','cc-by-sa-nc/sound/weapons/punch4.ogg')
		if ("clownstep") soundin = pick('cc-by-sa-nc/sound/misc/clownstep1.ogg','cc-by-sa-nc/sound/misc/clownstep2.ogg')
		if ("swing_hit") soundin = pick('cc-by-sa-nc/sound/weapons/genhit1.ogg', 'cc-by-sa-nc/sound/weapons/genhit2.ogg', 'cc-by-sa-nc/sound/weapons/genhit3.ogg')

	var/sound/S = sound(soundin)
	S.wait = 0 //No queue
	S.channel = 0 //Any channel
	S.volume = vol

	if (vary)
		S.frequency = rand(32000, 55000)
	if(isturf(source))
		var/dx = source.x - src.x
		S.pan = max(-100, min(100, dx/8.0 * 100))
	src << S

client/verb/Toggle_Soundscape()
	usr:client:no_ambi = !usr:client:no_ambi
	if(usr:client:no_ambi)
		usr << sound('cc-by-sa-nc/sound/ambience/shipambience.ogg', repeat = 0, wait = 0, volume = 0, channel = 2)
	else
		usr << sound('cc-by-sa-nc/sound/ambience/shipambience.ogg', repeat = 1, wait = 0, volume = 50, channel = 2)
	usr << "Toggled ambience sound."
	return


/area/Entered(A)
	var/sound = null
	sound = 'cc-by-sa-nc/sound/ambience/ambigen1.ogg'

	if (ismob(A))

		if (istype(A, /mob/dead/observer)) return
		if (!A:client) return
		//if (A:ear_deaf) return

		if (A && A:client && !A:client:ambience_playing && !A:client:no_ambi) // Constant background noises
			A:client:ambience_playing = 1
			A << sound('cc-by-sa-nc/sound/ambience/shipambience.ogg', repeat = 1, wait = 0, volume = 50, channel = 2)

		switch(src.name)
			if ("Chapel") sound = pick('cc-by-sa-nc/sound/ambience/ambicha1.ogg','cc-by-sa-nc/sound/ambience/ambicha2.ogg','cc-by-sa-nc/sound/ambience/ambicha3.ogg','cc-by-sa-nc/sound/ambience/ambicha4.ogg')
			if ("Morgue") sound = pick('cc-by-sa-nc/sound/ambience/ambimo1.ogg','cc-by-sa-nc/sound/ambience/ambimo2.ogg')
			if ("Engine Control") sound = pick('cc-by-sa-nc/sound/ambience/ambieng1.ogg')
			if ("Atmospherics") sound = pick('cc-by-sa-nc/sound/ambience/ambiatm1.ogg')
			else sound = pick('cc-by-sa-nc/sound/ambience/ambigen1.ogg','cc-by-sa-nc/sound/ambience/ambigen2.ogg','cc-by-sa-nc/sound/ambience/ambigen3.ogg','cc-by-sa-nc/sound/ambience/ambigen4.ogg','cc-by-sa-nc/sound/ambience/ambigen5.ogg','cc-by-sa-nc/sound/ambience/ambigen6.ogg','cc-by-sa-nc/sound/ambience/ambigen7.ogg','cc-by-sa-nc/sound/ambience/ambigen8.ogg','cc-by-sa-nc/sound/ambience/ambigen9.ogg','cc-by-sa-nc/sound/ambience/ambigen10.ogg','cc-by-sa-nc/sound/ambience/ambigen11.ogg','cc-by-sa-nc/sound/ambience/ambigen12.ogg','cc-by-sa-nc/sound/ambience/ambigen13.ogg','cc-by-sa-nc/sound/ambience/ambigen14.ogg')

		if (prob(35))
			if(A && A:client && !A:client:played)
				A << sound(sound, repeat = 0, wait = 0, volume = 25, channel = 1)
				A:client:played = 1
				spawn(600)
					if(A && A:client)
						A:client:played = 0
