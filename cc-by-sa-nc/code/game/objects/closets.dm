/obj/closet/New()
	. = ..()
	update_icon()

/obj/closet/alter_health()
	return get_turf(src)

/obj/closet/proc/can_open()
	if (src.welded)
		return FALSE
	return TRUE

/obj/closet/proc/can_close()
	for(var/obj/closet/closet in get_turf(src))
		if(closet != src)
			return FALSE
	for(var/obj/secure_closet/closet in get_turf(src))
		return FALSE
	return TRUE

/obj/closet/proc/dump_contents()
	for (var/obj/item/I in src)
		I.loc = src.loc

	for (var/obj/overlay/o in src) //REMOVE THIS
		o.loc = src.loc

	for(var/mob/M in src)
		M.loc = src.loc
		if (M.client)
			M.client.eye = M.client.mob
			M.client.perspective = MOB_PERSPECTIVE

/obj/closet/proc/open()
	if (src.opened)
		return FALSE

	if (!src.can_open())
		return FALSE

	src.dump_contents()
	src.opened = 1
	update_icon()
	playsound(src.loc, 'cc-by-sa-nc/sound/machines/click.ogg', 15, 1, -3)
	return TRUE

/obj/closet/proc/close()
	if (!src.opened)
		return FALSE
	if (!src.can_close())
		return FALSE

	for (var/obj/item/I in src.loc)
		if (!I.anchored)
			I.loc = src

	for (var/obj/overlay/o in src.loc) //REMOVE THIS
		if (!o.anchored)
			o.loc = src

	for (var/mob/M in src.loc)
		if (M.buckled)
			continue

		if (M.client)
			M.client.perspective = EYE_PERSPECTIVE
			M.client.eye = src

		M.loc = src
	src.opened = 0
	update_icon()
	playsound(src.loc, 'cc-by-sa-nc/sound/machines/click.ogg', 15, 1, -3)
	return TRUE

/obj/closet/proc/toggle()
	if (src.opened)
		return src.close()
	return src.open()

/obj/closet/update_icon()
	src.overlays = 0

	if (src.opened)
		overlays += image(icon, icon_opened)
	else
		overlays += image(icon, icon_closed)

/obj/closet/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (src.opened)
		if (istype(W, /obj/item/weapon/grab))
			src.MouseDrop_T(W:affecting, user)      //act like they were dragged onto the closet

		usr.drop_item()

		if (W)
			W.loc = src.loc
	else
		src.attack_hand(user)
	return

/obj/closet/MouseDrop_T(atom/movable/O as mob|obj, mob/user as mob)
	if (!user.can_use_hands())
		return
	if ((!( istype(O, /atom/movable) ) || O.anchored || get_dist(user, src) > 1 || get_dist(user, O) > 1 || user.contents.Find(src)))
		return
	if (user.loc==null) // just in case someone manages to get a closet into the blue light dimension, as unlikely as that seems
		return
	if (!istype(user.loc, /turf)) // are you in a container/closet/pod/etc?
		return
	if(!src.opened)
		return
	if(istype(O, /obj/secure_closet) || istype(O, /obj/closet))
		return
	step_towards(O, src.loc)
	user.show_viewers(text("\red [] stuffs [] into []!", user, O, src))
	src.add_fingerprint(user)
	return

/obj/closet/relaymove(mob/user as mob)
	if (user.stat)
		return

	if (!src.open())
		user << "\blue It won't budge!"
		for (var/mob/M in hearers(src, null))
			M << text("<FONT size=[]>BANG, bang!</FONT>", max(0, 5 - get_dist(src, M)))

/obj/closet/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/closet/attack_hand(mob/user as mob)
	src.add_fingerprint(user)

	if (!src.toggle())
		usr << "\blue It won't budge!"
