
/obj/item/stack
	var/count = 10
	var/max_stack = 10

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
	icon = 'assets/cc-by-sa-nc/icons_new/item/tools.dmi'
	icon_state = "floor-tile"
	count = 10
