/mob/living/carbon/human
	var
		oxygen_alert = 0
		toxins_alert = 0
		fire_alert = 0

		temperature_alert = 0


/mob/living/carbon/human/Life()
	set invisibility = 0
	set background = 1

	if (src.monkeyizing)
		return

	if (src.stat != 2) //still breathing

		//First, resolve location and get a breath
		spawn(0) breathe()

	//Apparently, the person who wrote this code designed it so that
	//blinded get reset each cycle and then get activated later in the
	//code. Very ugly. I dont care. Moving this stuff here so its easy
	//to find it.
	src.blinded = null

	//Disease Check
	handle_virus_updates()

	//Mutations and radiation
	handle_mutations_and_radiation()

	//Chemicals in the body
	handle_chemicals_in_body()

	//Disabilities
	handle_disabilities()

	//Status updates, death etc.
	handle_regular_status_updates()

	// Update clothing
	update_clothing()

	if(client)
		handle_regular_hud_updates()

	//Being buckled to a chair or bed
	check_if_buckled()

	// Yup.
	update_canmove()

	clamp_values()

	// Grabbing
	for(var/obj/item/weapon/grab/G in src)
		G.process()


/mob/living/carbon/human

/mob/living/carbon/human/proc/clamp_values()
	stunned = max(min(stunned, 20),0)
	paralysis = max(min(paralysis, 20), 0)
	weakened = max(min(weakened, 20), 0)
	sleeping = max(min(sleeping, 20), 0)
	bruteloss = max(bruteloss, 0)
	toxloss = max(toxloss, 0)
	oxyloss = max(oxyloss, 0)
	fireloss = max(fireloss, 0)


/mob/living/carbon/human/proc/handle_disabilities()

	if (src.disabilities & 2)
		if ((prob(1) && src.paralysis < 1 && src.r_epil < 1))
			src << "\red You have a seizure!"
			for(var/mob/O in viewers(src, null))
				if(O == src)
					continue
				O.show_message(text("\red <B>[src] starts having a seizure!"), 1)
			src.paralysis = max(10, src.paralysis)
			src.make_jittery(1000)
	if (src.disabilities & 4)
		if ((prob(5) && src.paralysis <= 1 && src.r_ch_cou < 1))
			src.drop_item()
			spawn( 0 )
				emote("cough")
				return
	if (src.disabilities & 8)
		if ((prob(10) && src.paralysis <= 1 && src.r_Tourette < 1))
			src.stunned = max(10, src.stunned)
			spawn( 0 )
				switch(rand(1, 3))
					if(1)
						emote("twitch")
					if(2 to 3)
						say("[prob(50) ? ";" : ""][pick("SHIT", "PISS", "FUCK", "CUNT", "COCKSUCKER", "MOTHERFUCKER", "TITS")]")
				var/old_x = src.pixel_x
				var/old_y = src.pixel_y
				src.pixel_x += rand(-2,2)
				src.pixel_y += rand(-1,1)
				sleep(2)
				src.pixel_x = old_x
				src.pixel_y = old_y
				return
	if (src.disabilities & 16)
		if (prob(10))
			src.stuttering = max(10, src.stuttering)
	if (src.brainloss >= 60 && src.stat != 2)
		if (prob(7))
			switch(pick(1,2,3))
				if(1)
					say(pick("IM A PONY NEEEEEEIIIIIIIIIGH", "without oxigen blob don't evoluate?", "CAPTAINS A COMDOM", "[pick("", "that faggot traitor")] [pick("joerge", "george", "gorge", "gdoruge")] [pick("mellens", "melons", "mwrlins")] is grifing me HAL;P!!!", "can u give me [pick("telikesis","halk","eppilapse")]?", "THe saiyans screwed", "Bi is THE BEST OF BOTH WORLDS>", "I WANNA PET TEH MONKIES", "stop grifing me!!!!", "SOTP IT#"))
				if(2)
					emote("fart")
				if(3)
					emote("drool")

/mob/living/carbon/human/proc/handle_mutations_and_radiation()
	if(src.fireloss)
		if(prob(50))
			switch(src.fireloss)
				if(1 to 50)
					src.fireloss--
				if(51 to 100)
					src.fireloss -= 5

	if (src.radiation)
		if (src.radiation > 100)
			src.radiation = 100
			src.weakened = 10
			src << "\red You feel weak."
			emote("collapse")

		if (src.radiation < 0)
			src.radiation = 0

		switch(src.radiation)
			if(1 to 49)
				src.radiation--
				if(prob(25))
					src.toxloss++
					src.updatehealth()

			if(50 to 74)
				src.radiation -= 2
				src.toxloss++
				if(prob(5))
					src.radiation -= 5
					src.weakened = 3
					src << "\red You feel weak."
					emote("collapse")
				src.updatehealth()

			if(75 to 100)
				src.radiation -= 3
				src.toxloss += 3
				if(prob(1))
					src << "\red You feel your DNA being torn apart!"
					//randmutb(src)
					//domutcheck(src,null)
					emote("gasp")
				src.updatehealth()


/mob/living/carbon/human/proc/breathe()

	var/turf/resolved_loc = find_turf()
	var/in_space = istype(resolved_loc, /turf/space) || istype(resolved_loc.loc, /area/space)

	src.internals.icon_state = "internal0"

	if (in_space)
		if(prob(20))
			spawn(0) emote("gasp")
		oxyloss += 7
		oxygen_alert = TRUE
		return TRUE
	else
		oxyloss = max(oxyloss-5, 0)
		oxygen_alert = FALSE

/mob/living/carbon/human/proc/update_canmove()
	if(paralysis || stunned || weakened || buckled) canmove = 0
	else canmove = 1

/mob/living/carbon/human/proc/adjust_body_temperature(current, loc_temp, boost)
	var/temperature = current
	var/difference = abs(current-loc_temp)	//get difference
	var/increments// = difference/10			//find how many increments apart they are
	if(difference > 50)
		increments = difference/5
	else
		increments = difference/10
	var/change = increments*boost	// Get the amount to change by (x per increment)
	var/temp_change
	if(current < loc_temp)
		temperature = min(loc_temp, temperature+change)
	else if(current > loc_temp)
		temperature = max(loc_temp, temperature-change)
	temp_change = (temperature - current)
	return temp_change

/mob/living/carbon/human/proc/get_thermal_protection()
	var/thermal_protection = 1.0
	//Handle normal clothing
	if(head && (head.body_parts_covered & HEAD))
		thermal_protection += 0.5
	if(wear_suit && (wear_suit.body_parts_covered & UPPER_TORSO))
		thermal_protection += 0.5
	if(w_uniform && (w_uniform.body_parts_covered & UPPER_TORSO))
		thermal_protection += 0.5
	if(wear_suit && (wear_suit.body_parts_covered & LEGS))
		thermal_protection += 0.2
	if(wear_suit && (wear_suit.body_parts_covered & ARMS))
		thermal_protection += 0.2
	if(wear_suit && (wear_suit.body_parts_covered & HANDS))
		thermal_protection += 0.2
	if(shoes && (shoes.body_parts_covered & FEET))
		thermal_protection += 0.2
	if(wear_suit && (wear_suit.flags & SUITSPACE))
		thermal_protection += 3
	if(head && (head.flags & HEADSPACE))
		thermal_protection += 1

	return thermal_protection

/mob/living/carbon/human/proc/add_fire_protection(var/temp)
	var/fire_prot = 0
	if(head)
		if(head.protective_temperature > temp)
			fire_prot += (head.protective_temperature/10)
	if(wear_mask)
		if(wear_mask.protective_temperature > temp)
			fire_prot += (wear_mask.protective_temperature/10)
	if(glasses)
		if(glasses.protective_temperature > temp)
			fire_prot += (glasses.protective_temperature/10)
	if(ears)
		if(ears.protective_temperature > temp)
			fire_prot += (ears.protective_temperature/10)
	if(wear_suit)
		if(wear_suit.protective_temperature > temp)
			fire_prot += (wear_suit.protective_temperature/10)
	if(w_uniform)
		if(w_uniform.protective_temperature > temp)
			fire_prot += (w_uniform.protective_temperature/10)
	if(gloves)
		if(gloves.protective_temperature > temp)
			fire_prot += (gloves.protective_temperature/10)
	if(shoes)
		if(shoes.protective_temperature > temp)
			fire_prot += (shoes.protective_temperature/10)

	return fire_prot

/mob/living/carbon/human/proc/handle_temperature_damage(body_part, exposed_temperature, exposed_intensity)
	if(src.nodamage)
		return
	var/discomfort = min(abs(exposed_temperature - bodytemperature)*(exposed_intensity)/2000000, 1.0)

	switch(body_part)
		if(HEAD)
			TakeDamage("head", 0, 2.5*discomfort)
		if(UPPER_TORSO)
			TakeDamage("chest", 0, 2.5*discomfort)
		if(LOWER_TORSO)
			TakeDamage("groin", 0, 2.0*discomfort)
		if(LEGS)
			TakeDamage("l_leg", 0, 0.6*discomfort)
			TakeDamage("r_leg", 0, 0.6*discomfort)
		if(ARMS)
			TakeDamage("l_arm", 0, 0.4*discomfort)
			TakeDamage("r_arm", 0, 0.4*discomfort)
		if(FEET)
			TakeDamage("l_foot", 0, 0.25*discomfort)
			TakeDamage("r_foot", 0, 0.25*discomfort)
		if(HANDS)
			TakeDamage("l_hand", 0, 0.25*discomfort)
			TakeDamage("r_hand", 0, 0.25*discomfort)

/mob/living/carbon/human/proc/handle_chemicals_in_body()

	if (src.nutrition > 0)
		src.nutrition--

	if (src.drowsyness)
		src.drowsyness--
		src.eye_blurry = max(2, src.eye_blurry)
		if (prob(5))
			src.sleeping = 1
			src.paralysis = 5

	confused = max(0, confused - 1)
	// decrement dizziness counter, clamped to 0
	if(resting)
		dizziness = max(0, dizziness - 5)
		jitteriness = max(0, jitteriness - 5)
	else
		dizziness = max(0, dizziness - 1)
		jitteriness = max(0, jitteriness - 1)

	src.updatehealth()

	return //TODO: DEFERRED

/mob/living/carbon/human/proc/handle_regular_status_updates()

	health = 100 - (oxyloss + toxloss + fireloss + bruteloss)

	if(oxyloss > 50) paralysis = max(paralysis, 3)

	if(src.sleeping)
		src.paralysis = max(src.paralysis, 3)
		if (prob(10) && health) spawn(0) emote("snore")
		src.sleeping--

	if(src.resting)
		src.weakened = max(src.weakened, 5)

	if(health < -100 || src.brain_op_stage == 4.0)
		death()
	else if(src.health < 0)
		if(src.health <= 20 && prob(1)) spawn(0) emote("gasp")

		//if(!src.rejuv) src.oxyloss++

		if(src.stat != 2)	src.stat = 1
		src.paralysis = max(src.paralysis, 5)

	if (src.stat != 2) //Alive.

		if (src.paralysis || src.stunned || src.weakened) //Stunned etc.
			if (src.stunned > 0)
				src.stunned--
				src.stat = 0
			if (src.weakened > 0)
				src.weakened--
				src.lying = 1
				src.stat = 0
			if (src.paralysis > 0)
				src.paralysis--
				src.blinded = 1
				src.lying = 1
				src.stat = 1
			var/h = src.hand
			src.hand = 0
			drop_item()
			src.hand = 1
			drop_item()
			src.hand = h

		else	//Not stunned.
			src.lying = 0
			src.stat = 0

	else //Dead.
		src.lying = 1
		src.blinded = 1
		src.stat = 2

	if (src.stuttering) src.stuttering--

	if (src.eye_blind == 1)
		src.eye_blind--
		src.blinded = 1

	if (src.ear_deaf > 0) src.ear_deaf--
	if (src.ear_damage < 25)
		src.ear_damage -= 0.05
		src.ear_damage = max(src.ear_damage, 0)

	src.density = !( src.lying )

	if ((src.sdisabilities & 1 || istype(src.glasses, /obj/item/clothing/glasses/blindfold)))
		src.blinded = 1
	if ((src.sdisabilities & 4 || istype(src.ears, /obj/item/clothing/ears/earmuffs)))
		src.ear_deaf = 1

	if (src.eye_blurry > 0)
		src.eye_blurry--
		src.eye_blurry = max(0, src.eye_blurry)

	if (src.druggy > 0)
		src.druggy--
		src.druggy = max(0, src.druggy)

	return TRUE

/mob/living/carbon/human/proc/handle_regular_hud_updates()

	if (src.sleep) src.sleep.icon_state = text("sleep[]", src.sleeping)
	if (src.rest) src.rest.icon_state = text("rest[]", src.resting)

	if (src.healths)
		if (src.stat != 2)
			switch(health)
				if(100 to INFINITY)
					src.healths.icon_state = "health0"
				if(80 to 100)
					src.healths.icon_state = "health1"
				if(60 to 80)
					src.healths.icon_state = "health2"
				if(40 to 60)
					src.healths.icon_state = "health3"
				if(20 to 40)
					src.healths.icon_state = "health4"
				if(0 to 20)
					src.healths.icon_state = "health5"
				else
					src.healths.icon_state = "health6"
		else
			src.healths.icon_state = "health7"

	if(src.pullin)	src.pullin.icon_state = "pull[src.pulling ? 1 : 0]"


	if (src.toxin)	src.toxin.icon_state = "tox[src.toxins_alert ? 1 : 0]"
	if (src.oxygen) src.oxygen.icon_state = "oxy[src.oxygen_alert ? 1 : 0]"
	if (src.fire) src.fire.icon_state = "fire[src.fire_alert ? 1 : 0]"
	//NOTE: the alerts dont reset when youre out of danger. dont blame me,
	//blame the person who coded them. Temporary fix added.

	switch(src.bodytemperature) //310.055 optimal body temp

		if(370 to INFINITY)
			src.bodytemp.icon_state = "temp4"
		if(350 to 370)
			src.bodytemp.icon_state = "temp3"
		if(335 to 350)
			src.bodytemp.icon_state = "temp2"
		if(320 to 335)
			src.bodytemp.icon_state = "temp1"
		if(300 to 320)
			src.bodytemp.icon_state = "temp0"
		if(295 to 300)
			src.bodytemp.icon_state = "temp-1"
		if(280 to 295)
			src.bodytemp.icon_state = "temp-2"
		if(260 to 280)
			src.bodytemp.icon_state = "temp-3"
		else
			src.bodytemp.icon_state = "temp-4"

	src.client.screen -= src.hud_used.blurry
	src.client.screen -= src.hud_used.druggy
	src.client.screen -= src.hud_used.vimpaired

	if (src.blind && src.stat != 2)
		src.blind.invisibility = 101

		if (src.disabilities & 1 && !istype(src.glasses, /obj/item/clothing/glasses/regular) )
			src.client.screen += src.hud_used.vimpaired

		if (src.eye_blurry)
			src.client.screen += src.hud_used.blurry

		if (src.druggy)
			src.client.screen += src.hud_used.druggy

	if (src.stat != 2)
		if (src.machine)
			if (!( src.machine.check_eye(src) ))
				src.reset_view(null)
	return TRUE

/mob/living/carbon/human/proc/handle_random_events()
	if (prob(1) && prob(2))
		spawn(0)
			emote("sneeze")
			return

/mob/living/carbon/human/proc/handle_virus_updates()
	if(src.bodytemperature > 406)
		src.resistances += src.virus
		src.virus = null

	if(!src.virus)
		if(prob(40))
			for(var/mob/living/carbon/M in oviewers(4, src))
				if(M.virus && M.virus.spread == "Airborne")
					if(M.virus.affected_species.Find("Human"))
						if(src.resistances.Find(M.virus.type))
							continue
						var/datum/disease/D = new M.virus.type //Making sure strain_data is preserved
						D.strain_data = M.virus.strain_data
						src.contract_disease(D)
			for(var/obj/decal/cleanable/blood/B in view(4, src))
				if(B.virus && B.virus.spread == "Airborne")
					if(B.virus.affected_species.Find("Human"))
						if(src.resistances.Find(B.virus.type))
							continue
						var/datum/disease/D = new B.virus.type
						D.strain_data = B.virus.strain_data
						src.contract_disease(D)
	else
		src.virus.stage_act()

/mob/living/carbon/human/proc/check_if_buckled()
	if (src.buckled)
		src.lying = istype(src.buckled, /obj/stool/bed)
		if(src.lying)
			src.drop_item()
		src.density = 1
	else
		src.density = !src.lying
