
/obj/decal/ash/attack_hand(mob/user as mob)
	usr << "\blue The ashes slip through your fingers."
	del(src)
	return
/obj/bullet/Bump(atom/A as mob|obj|turf|area)
	spawn(0)
		if(A)
			A.bullet_act(PROJECTILE_BULLET, src)
			if(istype(A,/turf))
				for(var/obj/O in A)
					O.bullet_act(PROJECTILE_BULLET, src)

		del(src)
	return

/obj/bullet/weakbullet/Bump(atom/A as mob|obj|turf|area)
	spawn(0)
		if(A)
			A.bullet_act(PROJECTILE_WEAKBULLET, src)
			if(istype(A,/turf))
				for(var/obj/O in A)
					O.bullet_act(PROJECTILE_WEAKBULLET, src)

		del(src)
	return

/obj/bullet/electrode/Bump(atom/A as mob|obj|turf|area)
	spawn(0)
		if(A)
			A.bullet_act(PROJECTILE_TASER)
			if(istype(A,/turf))
				for(var/obj/O in A)
					O.bullet_act(PROJECTILE_TASER, src)
		del(src)
	return

/obj/bullet/cbbolt/Bump(atom/A as mob|obj|turf|area)
	spawn(0)
		if(A)
			A.bullet_act(PROJECTILE_BOLT)
			if(istype(A,/turf))
				for(var/obj/O in A)
					O.bullet_act(PROJECTILE_BOLT, src)
		del(src)
	return

/obj/bullet/teleshot/Bump(atom/A as mob|obj|turf|area)
	if (src.target == null)
		var/list/turfs = list(	)
		for(var/turf/T in orange(10, src))
			if(T.x>world.maxx-4 || T.x<4)	continue	//putting them at the edge is dumb
			if(T.y>world.maxy-4 || T.y<4)	continue
			turfs += T
		if(turfs)
			src.target = pick(turfs)
	if (!src.target)
		del(src)
		return
	spawn(0)
		if(A)
			var/turf/T = get_turf(A)
			for(var/atom/movable/M in T)
				if(istype(M, /obj/effects)) //sparks don't teleport
					continue
				if (M.anchored)
					continue
				if (istype(M, /atom/movable))
					var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
					s.set_up(5, 1, M)
					s.start()
					if(prob(src.failchance)) //oh dear a problem, put em in deep space
						do_teleport(M, locate(rand(5, world.maxx - 5), rand(5, world.maxy -5), 3), 0)
					else
						do_teleport(M, src.target, 2)
		del(src)
	return

/obj/bullet/proc/process()
	if ((!( src.current ) || src.loc == src.current))
		src.current = locate(min(max(src.x + src.xo, 1), world.maxx), min(max(src.y + src.yo, 1), world.maxy), src.z)
	if ((src.x == 1 || src.x == world.maxx || src.y == 1 || src.y == world.maxy))
		//SN src = null
		del(src)
		return
	step_towards(src, src.current)
	spawn( 1 )
		process()
		return
	return

/obj/beam/a_laser/Bump(atom/A as mob|obj|turf|area)
	spawn(0)
		if(A)
			A.bullet_act(PROJECTILE_LASER, src)
		del(src)

/obj/beam/a_laser/proc/process()
	//world << text("laser at [] []:[], target is [] []:[]", src.loc, src.x, src.y, src:current, src.current:x, src.current:y)
	if ((!( src.current ) || src.loc == src.current))
		src.current = locate(min(max(src.x + src.xo, 1), world.maxx), min(max(src.y + src.yo, 1), world.maxy), src.z)
		//world << text("current changed: target is now []. location was [],[], added [],[]", src.current, src.x, src.y, src.xo, src.yo)
	if ((src.x == 1 || src.x == world.maxx || src.y == 1 || src.y == world.maxy))
		//world << text("off-world, deleting")
		//SN src = null
		del(src)
		return
	step_towards(src, src.current)
	// make it able to hit lying-down folk
	var/list/dudes = list()
	for(var/mob/M in src.loc)
		dudes += M
	if(dudes.len)
		src.Bump(pick(dudes))
	//world << text("laser stepped, now [] []:[], target is [] []:[]", src.loc, src.x, src.y, src.current, src.current:x, src.current:y)
	src.life--
	if (src.life <= 0)
		//SN src = null
		del(src)
		return

	spawn(1)
		src.process()
		return
	return

/obj/beam/i_beam/proc/hit()
	//world << "beam \ref[src]: hit"
	//SN src = null
	del(src)
	return

/obj/beam/i_beam/proc/vis_spread(v)
	//world << "i_beam \ref[src] : vis_spread"
	src.visible = v
	spawn( 0 )
		if (src.next)
			//world << "i_beam \ref[src] : is next [next.type] \ref[next], calling spread"
			src.next.vis_spread(v)
		return
	return

/obj/beam/i_beam/proc/process()
	//world << "i_beam \ref[src] : process"

	if ((src.loc.density || !( src.master )))
		//SN src = null
	//	world << "beam hit loc [loc] or no master [master], deleting"
		del(src)
		return
	//world << "proccess: [src.left] left"

	if (src.left > 0)
		src.left--
	if (src.left < 1)
		if (!( src.visible ))
			src.invisibility = 101
		else
			src.invisibility = 0
	else
		src.invisibility = 0


	//world << "now [src.left] left"
	var/obj/beam/i_beam/I = new /obj/beam/i_beam( src.loc )
	I.master = src.master
	I.density = 1
	I.dir = src.dir
	//world << "created new beam \ref[I] at [I.x] [I.y] [I.z]"
	step(I, I.dir)

	if (I)
		//world << "step worked, now at [I.x] [I.y] [I.z]"
		if (!( src.next ))
			//world << "no src.next"
			I.density = 0
			//world << "spreading"
			I.vis_spread(src.visible)
			src.next = I
			spawn( 0 )
				//world << "limit = [src.limit] "
				if ((I && src.limit > 0))
					I.limit = src.limit - 1
					//world << "calling next process"
					I.process()
				return
		else
			//world << "is a next: \ref[next], deleting beam \ref[I]"
			//I = null
			del(I)
	else
		//src.next = null
		//world << "step failed, deleting \ref[src.next]"
		del(src.next)
	spawn( 10 )
		src.process()
		return
	return

/obj/beam/i_beam/Bump()
	del(src)
	return

/obj/beam/i_beam/Bumped()
	src.hit()
	return

/obj/beam/i_beam/HasEntered(atom/movable/AM as mob|obj)
	if (istype(AM, /obj/beam))
		return
	spawn( 0 )
		src.hit()
		return
	return

/obj/beam/i_beam/Del()
	del(src.next)
	..()
	return

/atom/proc/ex_act()
	return

// bullet_act called when anything is hit buy a projectile (bullet, tazer shot, laser, etc.)
// flag is projectile type, can be:
//PROJECTILE_TASER = 1   		taser gun
//PROJECTILE_LASER = 2			laser gun
//PROJECTILE_BULLET = 3			traitor pistol
//PROJECTILE_PULSE = 4			pulse rifle
//PROJECTILE_BOLT = 5			crossbow
//PROJECTILE_WEAKBULLET = 6		detective's revolver

/atom/proc/bullet_act(flag)
	if(flag == PROJECTILE_PULSE)
		src.ex_act(2)
	return


/turf/Entered(atom/A as mob|obj)
	..()
	if ((A && A.density && !( istype(A, /obj/beam) )))
		for(var/obj/beam/i_beam/I in src)
			spawn( 0 )
				if (I)
					I.hit()
				return
	return

/obj/item/weapon/mousetrap/examine()
	set src in oview(12)
	..()
	if(armed)
		usr << "\red It looks like it's armed."

/obj/item/weapon/mousetrap/proc/triggered(mob/target as mob, var/type = "feet")
	if(!armed)
		return
	var/datum/organ/external/affecting = null
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		switch(type)
			if("feet")
				if(!H.shoes)
					affecting = H.organs[pick("l_foot", "r_foot")]
					H.weakened = max(3, H.weakened)
			if("l_hand", "r_hand")
				if(!H.gloves)
					affecting = H.organs[type]
					H.stunned = max(3, H.stunned)
		if(affecting)
			affecting.take_damage(1, 0)
			H.UpdateDamageIcon()
			H.updatehealth()
	playsound(target.loc, 'cc-by-sa-nc/sound/effects/snap.ogg', 50, 1)
	icon_state = "mousetrap"
	armed = 0
/*
	else if (ismouse(target))
		target.bruteloss = 100
*/

/obj/item/weapon/mousetrap/attack_self(mob/user as mob)
	if(!armed)
		icon_state = "mousetraparmed"
		user << "\blue You arm the mousetrap."
	else
		icon_state = "mousetrap"
		if(user.brainloss >= 60)
			var/which_hand = "l_hand"
			if(!user.hand)
				which_hand = "r_hand"
			src.triggered(user, which_hand)
			user << "\red <B>You accidentally trigger the mousetrap!</B>"
			for(var/mob/O in viewers(user, null))
				if(O == user)
					continue
				O.show_message(text("\red <B>[user] accidentally sets off the mousetrap, breaking their fingers.</B>"), 1)
			return
		user << "\blue You disarm the mousetrap."
	armed = !armed
	playsound(user.loc, 'cc-by-sa-nc/sound/weapons/handcuffs.ogg', 30, 1, -3)

/obj/item/weapon/mousetrap/attack_hand(mob/user as mob)
	if(armed)
		if((user.brainloss >= 60))
			var/which_hand = "l_hand"
			if(!user.hand)
				which_hand = "r_hand"
			src.triggered(user, which_hand)
			user << "\red <B>You accidentally trigger the mousetrap!</B>"
			for(var/mob/O in viewers(user, null))
				if(O == user)
					continue
				O.show_message(text("\red <B>[user] accidentally sets off the mousetrap, breaking their fingers.</B>"), 1)
			return
	..()

/obj/item/weapon/mousetrap/HasEntered(AM as mob|obj)
	if((ishuman(AM)) && (armed))
		var/mob/living/carbon/H = AM
		if(H.m_intent == "run")
			src.triggered(H)
			H << "\red <B>You accidentally step on the mousetrap!</B>"
			for(var/mob/O in viewers(H, null))
				if(O == H)
					continue
				O.show_message(text("\red <B>[H] accidentally steps on the mousetrap.</B>"), 1)
	..()

/obj/item/weapon/mousetrap/hitby(A as mob|obj)
	if(!armed)
		return ..()
	for(var/mob/O in viewers(src, null))
		O.show_message(text("\red <B>The mousetrap is triggered by [A].</B>"), 1)
	src.triggered(null)
