/mob/player/
	var/list/inventory = list()
	var/list/invslots = list()

/mob/player/proc/inv(slotname as text)
	if(slotname in src.invslots)
		var/obj/screen/inventoryslot/IS = src.invslots[slotname]
		return IS.inventory
	else
		return null

/mob/player/proc/setinvslot(slotname as text, item/I)
	if(slotname in src.invslots)
		var/obj/screen/inventoryslot/IS = src.invslots[slotname]
		if(IS.can_equipitem(I))
			IS.equipitem(I)
			return TRUE
		else
			return FALSE
	else
		return FALSE

/mob/player/proc/tryequip(item/I)
	for(var/slotname in src.invslots)
		var/success = src.setinvslot(slotname, I)
		if(success)
			return TRUE
	return FALSE

/obj/screen/inventoryslot
	name = "pocket"
	var/mob/player/owner = null
	var/item/inventory = null
	var/slot_name = "pocket"
	var/background = "background"
	icon = 'cc-by-sa-nc/icons/ui/screen_midnight.dmi'
	icon_state = "pocket"
	layer = -1

/obj/screen/inventoryslot/New(mob/player/M)
	. = ..()
	M.invslots[src.slot_name] = src
	src.owner = M
	underlays.Add(src.background)

/obj/screen/inventoryslot/MouseDropOn(obj/O as obj, mob/player/user as mob)
	if(!src.can_equipitem(O))
		return
	if(O.loc == user)
		user.client.screen -= O
	if(istype(O.loc, /obj/screen/inventoryslot))
		var/obj/screen/inventoryslot/IS = O.loc
		if(IS.can_unequipitem())
			IS.unequipitem(src)
		else
			return
	src.equipitem(O)
	
/obj/screen/inventoryslot/proc/can_equipitem(item/item)
	if(src.inventory)
		return FALSE
	if(!istype(item, /item))
		return FALSE
	return TRUE

/obj/screen/inventoryslot/proc/equipitem(item/item)
	src.inventory = item
	src.vis_contents = list(src.inventory)
	src.inventory.pixel_x = 0
	src.inventory.pixel_y = 0
	src.inventory.loc = src
	src.owner.inventory += item

/obj/screen/inventoryslot/proc/can_unequipitem()
	return TRUE

/obj/screen/inventoryslot/proc/unequipitem(atom/newloc)
	src.vis_contents = list()
	src.owner.inventory -= src.inventory
	src.inventory = null
