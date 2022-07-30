
/obj/item/stack
	var/count = 10
	var/max_stack = 10
	maptext_width = 16
	maptext_x = 16

/obj/item/stack/proc/add(var/amount)
	if (src.count + amount > src.max_stack)
		return FALSE

	src.count += amount
	src.update_icon()
	return TRUE

/obj/item/stack/proc/remove(var/amount = 1)
	if (amount > count)
		return FALSE

	src.count -= amount

	if (src.count <= 0)
		if (istype(loc, /obj/screen/inventoryslot))
			var/obj/screen/inventoryslot/S = src.loc
			S.unequipitem()
		spawn(0)
			del(src)

	src.update_icon()
	return amount

/obj/item/stack/update_icon()
	. = ..()
	if (src.equipped)
		src.maptext = "<font color='white'>[src.count]</font>"
	else
		src.maptext = ""

/obj/item/stack/HelpClick(mob/holder, atom/item, list/params)
	if (!src.Adjacent(holder))
		return

	if (istype(item, src.type))
		if (item:add(1))
			src.remove(1)
			holder.stdout("You take one [item.name]")
			return

	..()

/obj/item/stack/floor_tile
	name = "floor tiles"
	icon = 'assets/cc-by-sa-nc/icons_new/item/tools.dmi'
	icon_state = "floor-tile"
	count = 10
	max_stack = 20

/obj/item/stack/floor_tile/UseOn(mob/holder, atom/target, list/params)
	if (istype(target, /turf/basic/open/plating))
		var/turf/basic/open/plating/T = target
		if (src.remove(1))
			for (var/obj/structure/network_node/N in T.contents)
				N.invisibility = VISIBLITY_UNDER_TILE
			T.change_turf(/turf/basic/open/floor)
			play_sound('assets/cc-by-sa-nc/sound/items/Deconstruct.ogg', target)

/obj/item/stack/cable
	name = "cable coil"
	icon = 'assets/cc-by-sa-nc/icons_new/item/tools.dmi'
	icon_state = "coil"
	count = 20
	max_stack = 20
