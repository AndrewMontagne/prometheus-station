/obj/item/stack/cable
	name = "cable coil"
	icon = 'assets/cc-by-sa-nc/icons_new/item/tools.dmi'
	icon_state = "coil"
	count = 20
	max_stack = 20

/obj/item/stack/cable/UseOn(mob/holder, atom/target, list/params)
	if (istype(target, /turf/basic/open/plating))
		var/turf/basic/open/T = target
		var/turf/origin = holder.find_turf()
		if (src.remove(1))
			var/cable_dir = holder.dir
			if (target != origin)
				//same tile
				cable_dir = invert_dir(holder.dir)
			var/cable_state = "0-[cable_dir]"

			for (var/obj/structure/network_node/power/P in target.contents)
				if ("[cable_dir]" in P.dirs)
					holder.stdout("There is already a cable in that direction there!")
					return

			var/obj/structure/network_node/power/P = new(T)
			P.icon_state = cable_state
			LOG_TRACE(cable_state)
	else if (istype(target, /obj/structure/network_node/power))
		var/obj/structure/network_node/power/P = target
		var/turf/basic/open/T = target.find_turf()
		var/turf/origin = holder.find_turf()
		var/cable_dir = invert_dir(holder.dir)
		if (target == origin)
			return FALSE
		for (var/obj/structure/network_node/power/PO in target.contents)
			if ("[cable_dir]" in PO.dirs)
				holder.stdout("There is already a cable in that direction there!")
				return

		if (("0" in P.dirs) == FALSE)
			holder.stdout("You cannot join with this cable")
			return

		var/other_dir = text2num(P.dirs[2])
		var/cable_state = "[cable_dir]-[other_dir]"
		if (other_dir < cable_dir)
			cable_state = "[other_dir]-[cable_dir]"

		del(P)
		var/obj/structure/network_node/power/NP = new(T)
		NP.icon_state = cable_state
