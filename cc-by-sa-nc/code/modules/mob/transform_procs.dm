/mob/living/carbon/human/proc/monkeyize()
	if (src.monkeyizing)
		return
	for(var/obj/item/weapon/W in src)
		src.u_equip(W)
		if (src.client)
			src.client.screen -= W
		if (W)
			W.loc = src.loc
			W.dropped(src)
			W.layer = initial(W.layer)
	src.update_clothing()
	src.monkeyizing = 1
	src.canmove = 0
	src.icon = null
	src.invisibility = 101
	for(var/t in src.organs)
		//src.organs[text("[]", t)] = null
		del(src.organs[text("[]", t)])
	var/atom/movable/overlay/animation = new /atom/movable/overlay( src.loc )
	animation.icon_state = "blank"
	animation.icon = 'cc-by-sa-nc/icons/mob/mob.dmi'
	animation.master = src
	flick("h2monkey", animation)
	sleep(48)
	//animation = null
	del(animation)
	var/mob/living/carbon/monkey/O = new /mob/living/carbon/monkey( src.loc )

	O.name = "monkey"
	if (src.client)
		src.client.mob = O
	O.loc = src.loc
	O.a_intent = "hurt"
	O << "<B>You are now a monkey.</B>"
	/*
	if (ticker.mode.name == "monkey")
		O << "<B>Don't be angry at the source as now you are just like him so deal with it.</B>"
		O << "<B>Follow your objective.</B>"
	//SN src = null
	*/
	del(src)
	return

/mob/living/carbon/AIize()
	if (src.monkeyizing)
		return
	for(var/obj/item/weapon/W in src)
		src.u_equip(W)
		if (src.client)
			src.client.screen -= W
		if (W)
			W.loc = src.loc
			W.dropped(src)
			W.layer = initial(W.layer)
			del(W)
	src.update_clothing()
	src.monkeyizing = 1
	src.canmove = 0
	src.icon = null
	src.invisibility = 101
	for(var/t in src.organs)
		del(src.organs[text("[]", t)])


	..()


/mob/proc/AIize()
	src.client.screen.len = null
	var/mob/living/silicon/ai/O = new /mob/living/silicon/ai( src.loc )

	O.invisibility = 0
	O.canmove = 0
	O.name = src.name
	O.real_name = src.real_name
	O.anchored = 1
	O.aiRestorePowerRoutine = 0
	O.lastKnownIP = src.client.address

	mind.transfer_to(O)

	var/obj/loc_landmark
	//if (ticker.mode.name  == "AI malfunction")
		//loc_landmark = locate("landmark*ai")
	//else
	loc_landmark = locate(text("start*AI"))

	O.loc = loc_landmark.loc

	O << "<B>You are playing the station's AI. The AI cannot move, but can interact with many objects while viewing them (through cameras).</B>"
	O << "<B>To look at other parts of the station, double-click yourself to get a camera menu.</B>"
	O << "<B>While observing through a camera, you can use most (networked) devices which you can see, such as computers, APCs, intercoms, doors, etc.</B>"
	O << "To use something, simply double-click it."
	O << "Currently right-click functions will not work for the AI (except examine), and will either be replaced with dialogs or won't be usable by the AI."

	if (ticker.mode.name != "AI malfunction")
		O.laws_object = new /datum/ai_laws/asimov
		O.show_laws()
		O << "<b>These laws may be changed by other players, or by you being the traitor.</b>"

	O.verbs += /mob/living/silicon/ai/proc/ai_call_shuttle
	O.verbs += /mob/living/silicon/ai/proc/show_laws_verb
	O.verbs += /mob/living/silicon/ai/proc/ai_camera_track
	O.verbs += /mob/living/silicon/ai/proc/ai_alerts
	O.verbs += /mob/living/silicon/ai/proc/ai_camera_list
	O.verbs += /mob/living/silicon/ai/proc/lockdown
	O.verbs += /mob/living/silicon/ai/proc/disablelockdown
	O.verbs += /mob/living/silicon/ai/proc/ai_statuschange

//	O.verbs += /mob/living/silicon/ai/proc/ai_cancel_call
	O.job = "AI"

	spawn(0)
		var/randomname = pick(ai_names)
		var/newname = input(O,"You are the AI. Would you like to change your name to something else?", "Name change",randomname)

		if (length(newname) == 0)
			newname = randomname

		if (newname)
			if (length(newname) >= 26)
				newname = copytext(newname, 1, 26)
			newname = dd_replacetext(newname, ">", "'")
			O.real_name = newname
			O.name = newname

		world << text("<b>[O.real_name] is the AI!</b>")
		del(src)

	return O

//human -> alien
/mob/living/carbon/human/proc/Alienize()
	if (src.monkeyizing)
		return
	for(var/obj/item/weapon/W in src)
		src.u_equip(W)
		if (src.client)
			src.client.screen -= W
		if (W)
			W.loc = src.loc
			W.dropped(src)
			W.layer = initial(W.layer)
	src.update_clothing()
	src.monkeyizing = 1
	src.canmove = 0
	src.icon = null
	src.invisibility = 101
	for(var/t in src.organs)
		del(src.organs[t])
//	var/atom/movable/overlay/animation = new /atom/movable/overlay( src.loc )
//	animation.icon_state = "blank"
//	animation.icon = 'cc-by-sa-nc/icons/mob/mob.dmi'
//	animation.master = src
//	flick("h2alien", animation)
//	sleep(48)
//	del(animation)
	var/mob/living/carbon/alien/humanoid/O = new /mob/living/carbon/alien/humanoid( src.loc )
	O.name = "alien"
	if (src.client)
		src.client.mob = O
	O.loc = src.loc
	O.a_intent = "hurt"
	O << "<B>You are now an alien.</B>"
	del(src)
	return
