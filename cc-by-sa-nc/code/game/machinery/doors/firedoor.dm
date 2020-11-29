/var/const/OPEN = 1
/var/const/CLOSED = 2

/obj/machinery/door/firedoor/power_change()
	if( powered(ENVIRON) )
		stat &= ~NOPOWER
	else
		stat |= NOPOWER

/obj/machinery/door/firedoor/attackby(obj/item/weapon/C as obj, mob/user as mob)
	src.add_fingerprint(user)
	if ((istype(C, /obj/item/weapon/weldingtool) && !( src.operating ) && src.density))
		var/obj/item/weapon/weldingtool/W = C
		if(W.welding)
			if (W.get_fuel() > 2)
				W.use_fuel(2)
			if (!( src.blocked ))
				src.blocked = 1
			else
				src.blocked = 0
			update_icon()

			return
	if (!( istype(C, /obj/item/weapon/crowbar) ))
		return

	if (!src.blocked && !src.operating)
		if(src.density)
			spawn( 0 )
				src.operating = 1

				animate("opening")
				sleep(15)
				src.density = 0
				update_icon()

				src.set_opacity(0)
				src.operating = 0
				return
		else //close it up again
			spawn( 0 )
				src.operating = 1

				animate("closing")
				src.density = 1
				sleep(15)
				update_icon()

				src.set_opacity(1)
				src.operating = 0
				return
	return

/obj/machinery/door/firedoor/process()
	if(src.operating)
		return
	if(src.nextstate)
		if(src.nextstate == OPEN && src.density)
			spawn()
				src.open()
		else if(src.nextstate == CLOSED && !src.density)
			spawn()
				src.close()
		src.nextstate = null

/obj/machinery/door/firedoor/border_only
	CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		if(air_group)
			var/direction = get_dir(src,target)
			return (dir != direction)
		else if(density)
			if(!height)
				var/direction = get_dir(src,target)
				return (dir != direction)
			else
				return FALSE

		return TRUE

	update_nearby_tiles(need_rebuild)

		return TRUE
