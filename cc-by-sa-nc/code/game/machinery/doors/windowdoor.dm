/obj/machinery/door/window/update_nearby_tiles(need_rebuild)
	if(!air_master) return FALSE

	var/turf/simulated/source = loc
	var/turf/simulated/target = get_step(source,dir)

	if(need_rebuild)
		if(istype(source)) //Rebuild/update nearby group geometry
			if(source.parent)
				air_master.groups_to_rebuild += source.parent
			else
				air_master.tiles_to_update += source
		if(istype(target))
			if(target.parent)
				air_master.groups_to_rebuild += target.parent
			else
				air_master.tiles_to_update += target
	else
		if(istype(source)) air_master.tiles_to_update += source
		if(istype(target)) air_master.tiles_to_update += target

	return TRUE

/obj/machinery/door/window/New()
	..()

	if (src.req_access && src.req_access.len)
		src.icon_state = "[src.icon_state]"
		src.base_state = src.icon_state
	return

/obj/machinery/door/window/Bumped(atom/movable/AM as mob|obj)
	if (!( ticker ))
		return
	if (src.operating)
		return
	if (src.density && src.allowed(AM))
		open()
		if(src.check_access(null))
			sleep(50)
		else //secure doors close faster
			sleep(20)
		close()
	return

/obj/machinery/door/window/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(istype(mover, /obj/beam))
		return TRUE
	if(get_dir(loc, target) == dir) //Make sure looking at appropriate border
		if(air_group) return FALSE
		return !density
	else
		return TRUE

/obj/machinery/door/window/CheckExit(atom/movable/mover as mob|obj, turf/target as turf)
	if(istype(mover, /obj/beam))
		return TRUE
	if(get_dir(loc, target) == dir)
		return !density
	else
		return TRUE

/obj/machinery/door/window/open()
	if (src.operating == 1) //doors can still open when emag-disabled
		return FALSE
	if (!ticker)
		return FALSE
	if(!src.operating) //in case of emag
		src.operating = 1
	flick(text("[]opening", src.base_state), src)
	playsound(src.loc, 'cc-by-sa-nc/sound/machines/windowdoor.ogg', 100, 1)
	src.icon_state = text("[]open", src.base_state)
	sleep(10)

	src.density = 0
	src.set_opacity(0)
	update_nearby_tiles()

	if(operating == 1) //emag again
		src.operating = 0
	return TRUE

/obj/machinery/door/window/close()
	if (src.operating)
		return FALSE
	src.operating = 1
	flick(text("[]closing", src.base_state), src)
	playsound(src.loc, 'cc-by-sa-nc/sound/machines/windowdoor.ogg', 100, 1)
	src.icon_state = text("[]", src.base_state)

	src.density = 1
	if (src.visible)
		src.set_opacity(1)
	update_nearby_tiles()

	sleep(10)

	src.operating = 0
	return TRUE

/obj/machinery/door/window/attackby(obj/item/I as obj, mob/user as mob)
	if (src.operating)
		return
	src.add_fingerprint(user)
	if (!src.requiresID())
		//don't care who they are or what they have, act as if they're NOTHING
		user = null
	if (src.density && istype(I, /obj/item/weapon/card/emag))
		src.operating = -1
		flick(text("[]spark", src.base_state), src)
		sleep(6)
		open()
		return TRUE
	if (src.allowed(user))
		if (src.density)
			open()
		else
			close()
	else if (src.density)
		flick(text("[]deny", src.base_state), src)
	return
