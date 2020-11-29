/obj/machinery/door/Bumped(atom/AM)
	if(p_open || operating) return
	if(ismob(AM))
		var/mob/M = AM
		if(world.timeofday - AM.last_bumped <= 5) return
		if(M.client && !M:handcuffed) attack_hand(M)

/obj/machinery/door/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group) return FALSE
	if(istype(mover, /obj/beam))
		return !opacity
	return !density

/obj/machinery/door/proc/update_nearby_tiles(need_rebuild)
	return TRUE

/obj/machinery/door
	New()
		..()

		update_nearby_tiles(need_rebuild=1)

	Del()
		update_nearby_tiles()

		..()

/obj/machinery/door/attack_ai(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/door/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/door/attack_hand(mob/user as mob)
	return src.attackby(user, user)

/obj/machinery/door/proc/requiresID()
	return TRUE

/obj/machinery/door/attackby(obj/item/I as obj, mob/user as mob)
	if (src.operating)
		return
	src.add_fingerprint(user)
	if (!src.requiresID())
		//don't care who they are or what they have, act as if they're NOTHING
		user = null
	if (src.density && istype(I, /obj/item/weapon/card/emag))
		src.operating = -1
		flick("door_spark", src)
		sleep(6)
		open()
		return TRUE
	if (src.allowed(user))
		if (src.density)
			open()
		else
			close()
	else if (src.density)
		flick("door_deny", src)
	return

/obj/machinery/door/ex_act(severity)
	switch(severity)
		if(1.0)
			del(src)
		if(2.0)
			if(prob(25))
				del(src)
		if(3.0)
			if(prob(80))
				var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
				s.set_up(2, 1, src)
				s.start()

/obj/machinery/door/update_icon()
	if(density)
		icon_state = "door1"
	else
		icon_state = "door0"
	return

/obj/machinery/door/proc/do_animate(animation)
	switch(animation)
		if("opening")
			if(p_open)
				flick("o_doorc0", src)
			else
				flick("doorc0", src)
		if("closing")
			if(p_open)
				flick("o_doorc1", src)
			else
				flick("doorc1", src)
		if("deny")
			flick("door_deny", src)
	return

/obj/machinery/door/proc/open()
	if(!density)
		return TRUE
	if (src.operating == 1) //doors can still open when emag-disabled
		return
	if (!ticker)
		return FALSE
	if(!src.operating) //in case of emag
		src.operating = 1

	do_animate("opening")
	sleep(10)
	src.density = 0
	update_icon()

	src.set_opacity(0)
	update_nearby_tiles()

	if(operating == 1) //emag again
		src.operating = 0

	if(autoclose)
		spawn(150)
			autoclose()
	return TRUE

/obj/machinery/door/proc/close()
	if(density)
		return TRUE
	if (src.operating)
		return
	src.operating = 1

	do_animate("closing")
	src.density = 1
	sleep(10)
	update_icon()

	if (src.visible && (!istype(src, /obj/machinery/door/airlock/glass)))
		src.set_opacity(1)
	if(operating == 1)
		operating = 0
	update_nearby_tiles()

/obj/machinery/door/proc/autoclose()
	var/obj/machinery/door/airlock/A = src
	if ((!A.density) && !( A.operating ) && !(A.locked) && !( A.welded ))
		close()
	else return

/////////////////////////////////////////////////// Unpowered doors

/obj/machinery/door/unpowered
	autoclose = 0

/obj/machinery/door/unpowered/attack_ai(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/door/unpowered/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/door/unpowered/attack_hand(mob/user as mob)
	return src.attackby(null, user)

/obj/machinery/door/unpowered/attackby(obj/item/I as obj, mob/user as mob)
	if (src.operating)
		return
	src.add_fingerprint(user)
	if (src.allowed(user))
		if (src.density)
			open()
		else
			close()
	return

/obj/machinery/door/unpowered/shuttle
	icon = 'cc-by-sa-nc/icons/turf/shuttle.dmi'
	name = "door"
	icon_state = "door1"
	opacity = 1
	density = 1
