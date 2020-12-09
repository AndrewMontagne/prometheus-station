/obj/stool/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/wrench))
		playsound(src.loc, 'cc-by-sa-nc/sound/items/Ratchet.ogg', 50, 1)
		new /obj/item/weapon/sheet/metal( src.loc )
		//SN src = null
		del(src)
	return


/obj/stool/bed/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if (istype(W, /obj/item/weapon/wrench))
		playsound(src.loc, 'cc-by-sa-nc/sound/items/Ratchet.ogg', 50, 1)
		new /obj/item/weapon/sheet/metal( src.loc )
		del(src)
	return

/obj/stool/bed/Del()
	for(var/mob/M in src.loc)
		if (M.buckled == src)
			M.buckled = null
			M.lying = 0
			M.anchored = 0
	..()
	return

/obj/stool/bed/MouseDrop_T(mob/M as mob, mob/user as mob)
	if (!ticker)
		user << "You can't buckle anyone in before the game starts."
	if ((!( istype(M, /mob) ) || get_dist(src, user) > 1 || M.loc != src.loc || user.restrained() || usr.stat))
		return
	if (M == usr)
		for(var/mob/O in viewers(user, null))
			if ((O.client && !( O.blinded )))
				O << text("\blue [] buckles in!", M)
	else
		for(var/mob/O in viewers(user, null))
			if ((O.client && !( O.blinded )))
				O << text("\blue [] is buckled in by [].", M, user)
	M.lying = 1
	M.anchored = 1
	M.buckled = src
	M.loc = src.loc
	src.add_fingerprint(user)
	return

/obj/stool/bed/attack_hand(mob/user as mob)
	for(var/mob/M in src.loc)
		if (M.buckled)
			if (M != user)
				for(var/mob/O in viewers(user, null))
					if ((O.client && !( O.blinded )))
						O << text("\blue [] is unbuckled by [].", M, user)
			else
				for(var/mob/O in viewers(user, null))
					if ((O.client && !( O.blinded )))
						O << text("\blue [] unbuckles.", M)
//			world << "[M] is no longer buckled to [src]"
			M.anchored = 0
			M.buckled = null
			src.add_fingerprint(user)
	return

/obj/stool/chair/e_chair/New()

	src.overl = new /atom/movable/overlay( src.loc )
	src.overl.icon = icon
	src.overl.icon_state = "e_chair_over"
	src.overl.layer = 5
	src.overl.name = "electrified chair"
	src.overl.master = src
	return

/obj/stool/chair/e_chair/Del()

	//src.overl = null
	del(src.overl)
	..()
	return

/obj/stool/chair/e_chair/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (istype(W, /obj/item/weapon/wrench))
		del(src)
		return
	return

/obj/stool/chair/e_chair/verb/toggle_power()
	set src in oview(1)

	if ((usr.stat || usr.restrained() || !( usr.canmove ) || usr.lying))
		return
	src.on = !( src.on )
	src.icon_state = text("e_chair[]", src.on)
	src.overl.icon_state = text("e_chairo[]", src.on)
	return

/obj/stool/chair/e_chair/proc/shock()
	if (!( src.on ))
		return
	if ( (src.last_time + 50) > world.time)
		return
	src.last_time = world.time

	// special power handling
	var/area/A = get_area(src)
	if(!isarea(A))
		return
	if(!A.powered(EQUIP))
		return
	A.use_power(EQUIP, 5000)
	var/light = A.power_light
	A.updateicon()

	flick("e_chairs", src)
	flick("e_chairos", src.overl)
	for(var/mob/M in src.loc)
		M.burn_skin(85)
		M << "\red <B>You feel a deep shock course through your body!</B>"
		sleep(1)
		M.burn_skin(85)
		if(M.stunned < 600)	M.stunned = 600
	for(var/mob/M in hearers(src, null))
		M.show_message("\red The electric chair went off!.", 3, "\red You hear a deep sharp shock.", 2)

	A.power_light = light
	A.updateicon()
	return

/obj/stool/chair/New()
	src.verbs -= /atom/movable/verb/pull
	if (src.dir == NORTH)
		src.layer = FLY_LAYER
	..()
	return

/obj/stool/chair/Del()
	for(var/mob/M in src.loc)
		if (M.buckled == src)
			M.buckled = null
	..()
	return

/obj/stool/chair/verb/rotate()
	set src in oview(1)

	src.dir = turn(src.dir, 90)
	if (src.dir == NORTH)
		src.layer = FLY_LAYER
	else
		src.layer = OBJ_LAYER
	return

/obj/stool/chair/MouseDrop_T(mob/M as mob, mob/user as mob)
	if (!ticker)
		user << "You can't buckle anyone in before the game starts."
		return
	if ((!( istype(M, /mob) ) || get_dist(src, user) > 1 || M.loc != src.loc || user.restrained() || usr.stat))
		return
	if (M == usr)
		for(var/mob/O in viewers(user, null))
			if ((O.client && !( O.blinded )))
				O << text("\blue [] buckles in!", user)
	else
		for(var/mob/O in viewers(user, null))
			if ((O.client && !( O.blinded )))
				O << text("\blue [] is buckled in by []!", M, user)
	M.anchored = 1
	M.buckled = src
	M.loc = src.loc
	src.add_fingerprint(user)
	return

/obj/stool/chair/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/stool/chair/attack_hand(mob/user as mob)
	for(var/mob/M in src.loc)
		if (M.buckled)
			if (M != user)
				for(var/mob/O in viewers(user, null))
					if ((O.client && !( O.blinded )))
						O << text("\blue [] is unbuckled by [].", M, user)
			else
				for(var/mob/O in viewers(user, null))
					if ((O.client && !( O.blinded )))
						O << text("\blue [] unbuckles.", M)
//			world << "[M] is no longer buckled to [src]"
			M.anchored = 0
			M.buckled = null
			src.add_fingerprint(user)
	return
