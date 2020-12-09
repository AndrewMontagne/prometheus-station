//returns the netnum of a stub cable at this grille loc, or 0 if none

/obj/grille/proc/get_connection()
	var/turf/T = src.loc
	if(!istype(T, /turf/simulated/floor))
		return

	for(var/obj/cable/C in T)
		if(C.d1 == 0)
			return C.netnum

	return FALSE

/obj/grille/attack_hand(var/obj/M)
	if(!shock(usr, 70))
		usr << text("\blue You kick the grille.")
		for(var/mob/O in oviewers())
			if ((O.client && !( O.blinded )))
				O << text("\red [] kicks the grille.", usr)
		playsound(src.loc, 'cc-by-sa-nc/sound/effects/grillehit.ogg', 80, 1)
		src.health -= 1

/obj/grille/attack_paw(var/obj/M)
	if(!shock(usr, 70))
		usr << text("\blue You kick the grille.")
		for(var/mob/O in oviewers())
			if ((O.client && !( O.blinded )))
				O << text("\red [] kicks the grille.", usr)
		playsound(src.loc, 'cc-by-sa-nc/sound/effects/grillehit.ogg', 80, 1)
		src.health -= 1

/obj/grille/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return TRUE

	if (istype(mover, /obj/effects) || istype(mover, /obj/item/weapon/dummy) || istype(mover, /obj/beam))
		return TRUE
	else
		if (istype(mover, /obj/bullet))
			return prob(30)
		else
			return !src.density

/obj/grille/attackby(obj/item/weapon/W, mob/user)
	if (istype(W, /obj/item/weapon/wirecutters))
		if(!shock(user, 100))
			playsound(src.loc, 'cc-by-sa-nc/sound/items/Wirecutter.ogg', 100, 1)
			src.health = 0
	else if ((istype(W, /obj/item/weapon/screwdriver) && (istype(src.loc, /turf/simulated) || src.anchored)))
		if(!shock(user, 90))
			playsound(src.loc, 'cc-by-sa-nc/sound/items/Screwdriver.ogg', 100, 1)
			src.anchored = !( src.anchored )
			user << (src.anchored ? "You have fastened the grille to the floor." : "You have unfastened the grill.")
			for(var/mob/O in oviewers())
				O << text("\red [user] [src.anchored ? "fastens" : "unfastens"] the grille.")
			return
	else if(istype(W, /obj/item/weapon/shard))	// can't get a shock by attacking with glass shard
		src.health -= W.force * 0.1

	else						// anything else, chance of a shock
		if(!shock(user, 70))
			playsound(src.loc, 'cc-by-sa-nc/sound/effects/grillehit.ogg', 80, 1)
			switch(W.damtype)
				if("fire")
					src.health -= W.force
				if("brute")
					src.health -= W.force * 0.1

	src.healthcheck()
	..()
	return

/obj/grille/proc/healthcheck()
	if (src.health <= 0)
		if (!( src.destroyed ))
			src.icon_state = "brokengrille"
			src.density = 0
			src.destroyed = 1
			new /obj/item/weapon/rods( src.loc )

		else
			if (src.health <= -10.0)
				new /obj/item/weapon/rods( src.loc )
				//SN src = null
				del(src)
				return
	return

// shock user with probability prb (if all connections & power are working)
// returns 1 if shocked, 0 otherwise

/obj/grille/proc/shock(mob/user, prb)

	if(!anchored || destroyed)		// anchored/destroyed grilles are never connected
		return FALSE

	if(!prob(prb))
		return FALSE

	var/net = get_connection()		// find the powernet of the connected cable

	if(!net)		// cable is unpowered
		return FALSE

	return src.electrocute(user, prb, net)
