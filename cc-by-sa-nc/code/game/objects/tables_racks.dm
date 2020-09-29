/obj/table/ex_act(severity)

	switch(severity)
		if(1.0)
			//SN src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				//SN src = null
				del(src)
				return
		if(3.0)
			if (prob(25))
				src.density = 0
		else
	return

/obj/table/hand_p(mob/user as mob)
	return src.attack_paw(user)

/obj/table/attack_paw(mob/user as mob)
	if (!( locate(/obj/table, user.loc) ))
		step(user, get_dir(user, src))
		if (user.loc == src.loc)
			user.layer = TURF_LAYER
			for(var/mob/M in viewers(user, null))
				M.show_message("The monkey hides under the table!", 1)
				//Foreach goto(69)
	return

/obj/table/attack_hand(mob/user as mob)
	return



/obj/table/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return TRUE

	if (mover.flags & 2)
		return TRUE
	else
		return FALSE

/obj/table/MouseDrop_T(obj/O as obj, mob/user as mob)

	if ((!( istype(O, /obj/item/weapon) ) || user.equipped() != O))
		return
	user.drop_item()
	if (O.loc != src.loc)
		step(O, get_dir(O, src))
	return

/obj/table/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (istype(W, /obj/item/weapon/grab))
		var/obj/item/weapon/grab/G = W
		G.affecting.loc = src.loc
		G.affecting.weakened = 5
		for(var/mob/O in viewers(world.view, src))
			if (O.client)
				O << text("\red [] puts [] on the table.", G.assailant, G.affecting)
		del(W)
		return

	if (istype(W, /obj/item/weapon/wrench))
		user << "\blue Now dissembling table"
		playsound(src.loc, 'cc-by-sa-nc/sound/items/Ratchet.ogg', 50, 1)
		sleep(50)
		new /obj/item/weapon/table_parts( src.loc )
		playsound(src.loc, 'cc-by-sa-nc/sound/items/Deconstruct.ogg', 50, 1)
		//SN src = null
		del(src)
		return
	user.drop_item()
	if(W && W.loc)	W.loc = src.loc
	return

/obj/table/reinforced/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (istype(W, /obj/item/weapon/grab))
		var/obj/item/weapon/grab/G = W
		G.affecting.loc = src.loc
		G.affecting.weakened = 5
		for(var/mob/O in viewers(world.view, src))
			if (O.client)
				O << text("\red [] puts [] on the reinforced table.", G.assailant, G.affecting)
		del(W)
		return

	if (istype(W, /obj/item/weapon/weldingtool))
		if(src.status == 2)
			user << "\blue Now weakening the reinforced table"
			playsound(src.loc, 'cc-by-sa-nc/sound/items/Welder.ogg', 50, 1)
			sleep(50)
			user << "\blue Table weakened"
			src.status = 1
		else
			user << "\blue Now strengthening the reinforced table"
			playsound(src.loc, 'cc-by-sa-nc/sound/items/Welder.ogg', 50, 1)
			sleep(50)
			user << "\blue Table strengthened"
			src.status = 2
		return

	if (istype(W, /obj/item/weapon/wrench))
		if(src.status == 1)
			user << "\blue Now dissembling the reinforced table"
			playsound(src.loc, 'cc-by-sa-nc/sound/items/Ratchet.ogg', 50, 1)
			sleep(50)
			new /obj/item/weapon/table_parts/reinforced( src.loc )
			playsound(src.loc, 'cc-by-sa-nc/sound/items/Deconstruct.ogg', 50, 1)
			del(src)
			return
	user.drop_item()
	if(W && W.loc)	W.loc = src.loc
	return

/obj/rack/ex_act(severity)
	switch(severity)
		if(1.0)
			del(src)
			return
		if(2.0)
			if (prob(50))
				del(src)
				return
		if(3.0)
			if (prob(25))
				src.icon_state = "rackbroken"
				src.density = 0
		else
	return

/obj/rack/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return TRUE

	if (mover.flags & 2)
		return TRUE
	else
		return FALSE

/obj/rack/MouseDrop_T(obj/O as obj, mob/user as mob)
	if ((!( istype(O, /obj/item/weapon) ) || user.equipped() != O))
		return
	user.drop_item()
	if (O.loc != src.loc)
		step(O, get_dir(O, src))
	return

/obj/rack/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/weapon/rack_parts( src.loc )
		playsound(src.loc, 'cc-by-sa-nc/sound/items/Ratchet.ogg', 50, 1)
		//SN src = null
		del(src)
		return
	user.drop_item()
	if(W && W.loc)	W.loc = src.loc
	return
