/obj/item/weapon/bedsheet/attack_self(mob/user as mob)
	user.drop_item()
	src.layer = 5
	add_fingerprint(user)
	return


/obj/item/weapon/Bump(mob/M as mob)
	spawn( 0 )
		..()
	return

/obj/manifest/New()

	src.invisibility = 101
	return

/obj/manifest/proc/manifest()
	var/dat = "<B>Crew Manifest</B>:<BR>"
	for(var/mob/living/carbon/human/M in world)
		dat += text("    <B>[]</B> -  []<BR>", M.name, (istype(M.wear_id, /obj/item/weapon/card/id) ? text("[]", M.wear_id.assignment) : "Unknown Position"))
	var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( src.loc )
	P.info = dat
	P.name = "paper- 'Crew Manifest'"
	//SN src = null
	del(src)
	return

/obj/screen/close/DblClick()
	if (src.master)
		src.master:close(usr)
	return



/mob/attackby(obj/item/weapon/W as obj, mob/user as mob)
	var/shielded = 0
	for(var/obj/item/device/shield/S in src)
		if (S.active)
			shielded = 1
		else
	if (locate(/obj/item/weapon/grab, src))
		var/mob/safe = null
		if (istype(src.l_hand, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = src.l_hand
			if ((G.state == 3 && get_dir(src, user) == src.dir))
				safe = G.affecting
		if (istype(src.r_hand, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = src.r_hand
			if ((G.state == 3 && get_dir(src, user) == src.dir))
				safe = G.affecting
		if (safe)
			return safe.attackby(W, user)
	if ((!( shielded ) || !( W.flags ) & 32))
		spawn( 0 )
			W.attack(src, user)
			return
	return

/obj/item/brain/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M, /mob))
		return

	src.add_fingerprint(user)

	if(!(user.zone_sel.selecting == ("head")) || !istype(M, /mob/living/carbon/human))
		return ..()

	if(!(locate(/obj/machinery/optable, M.loc) && M.resting))
		return ..()

	var/mob/living/carbon/human/H = M
	if(istype(M, /mob/living/carbon/human) && ((H.head && H.head.flags & HEADCOVERSEYES) || (H.wear_mask && H.wear_mask.flags & MASKCOVERSEYES) || (H.glasses && H.glasses.flags & GLASSESCOVERSEYES)))
		// you can't stab someone in the eyes wearing a mask!
		user << "\blue You're going to need to remove that mask/helmet/glasses first."
		return

//since these people will be dead M != usr

	if(M:brain_op_stage == 4.0)
		for(var/mob/O in viewers(M, null))
			if(O == (user || M))
				continue
			if(M == user)
				O.show_message(text("\red [user] inserts [src] into his head!"), 1)
			else
				O.show_message(text("\red [M] has [src] inserted into his head by [user]."), 1)

		if(M != user)
			M << "\red [user] inserts [src] into your head!"
			user << "\red You insert [src] into [M]'s head!"
		else
			user << "\red You insert [src] into your head!"

		if(M.client)
			M.client.mob = new/mob/dead/observer(M)
		//a mob can't have two clients so get rid of one

		if(src.owner)
		//if the brain has an owner corpse
			if(src.owner.client)
			//if the player hasn't ghosted
				src.owner.client.mob = M
				//then put them in M
			else
			//if the player HAS ghosted
				for(var/mob/dead/observer/O in world)
					if(O.corpse == src.owner && O.client)
					//find their ghost
						O.client.mob = M
						//put their mob in M
						del(O)
						//delete thier ghost

		M:brain_op_stage = 3.0

		del(src)
	else
		..()
	return

/obj/item/weapon/stamp/attack_paw(mob/user as mob)

	return src.attack_hand(user)

/obj/item/weapon/stamp/New()

	..()
	return
