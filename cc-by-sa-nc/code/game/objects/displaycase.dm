/obj/displaycase/proc/healthcheck()
	if (src.health <= 0)
		if (!( src.destroyed ))
			src.density = 0
			src.destroyed = 1
			new /obj/item/weapon/shard( src.loc )
			playsound(src, "shatter", 70, 1)
			update_icon()
	else
		playsound(src.loc, 'cc-by-sa-nc/sound/effects/Glasshit.ogg', 75, 1)
	return

/obj/displaycase/update_icon()
	if(src.destroyed)
		src.icon_state = "glassboxb[src.occupied]"
	else
		src.icon_state = "glassbox[src.occupied]"
	return


/obj/displaycase/attackby(obj/item/weapon/W as obj, mob/user as mob)
	src.health -= W.force
	src.healthcheck()
	..()
	return

/obj/displaycase/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/displaycase/attack_hand(mob/user as mob)
	if (src.destroyed && src.occupied)
		new /obj/item/weapon/gun/energy/laser_gun/captain( src.loc )
		user << "\b You deactivate the hover field built into the case."
		src.occupied = 0
		src.add_fingerprint(user)
		update_icon()
		return
	else
		usr << text("\blue You kick the display case.")
		for(var/mob/O in oviewers())
			if ((O.client && !( O.blinded )))
				O << text("\red [] kicks the display case.", usr)
		src.health -= 2
		healthcheck()
		return


