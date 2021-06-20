/mob/player/
	var/list/inventory = list()
	var/list/invslots = list()

/mob/player/proc/inv(slotname as text)
	if(slotname in src.invslots)
		var/obj/screen/inventoryslot/IS = src.invslots[slotname]
		return IS.inventory
	else
		return null

/mob/player/proc/setinvslot(slotname as text, obj/item/I)
	if(slotname in src.invslots)
		var/obj/screen/inventoryslot/IS = src.invslots[slotname]
		if (IS.can_equipitem(I))
			if (I.equipped && I.slot.can_unequipitem())
				I.slot.unequipitem(IS)
			IS.equipitem(I)
			return TRUE
		else
			return FALSE
	else
		return FALSE

/mob/player/proc/tryequip(obj/item/I)
	var/list/hands = list()
	for(var/slotname in src.invslots)
		if (copytext(slotname,1,5) == "hand") // Defer hands until last
			hands += slotname
			continue
		var/success = src.setinvslot(slotname, I)
		if(success)
			return TRUE

	for(var/slotname in hands)
		var/success = src.setinvslot(slotname, I)
		if(success)
			return TRUE
	return FALSE

/obj/screen/inventoryslot
	name = SLOT_POCKET
	var/mob/player/owner = null
	var/obj/item/inventory = null
	var/inventory_plane = 0
	var/slot_name = SLOT_POCKET
	var/background = "background"
	icon = 'assets/cc-by-sa-nc/icons/ui/screen_midnight.dmi'
	icon_state = SLOT_POCKET
	layer = -1

/obj/screen/inventoryslot/New(mob/player/M)
	. = ..()
	M.invslots[src.slot_name] = src
	src.owner = M
	underlays.Add(src.background)

/obj/screen/inventoryslot/MouseDropOn(obj/O as obj, mob/player/user as mob)
	if(!src.can_equipitem(O))
		return
	if(istype(O.loc, /obj/screen/inventoryslot))
		var/obj/screen/inventoryslot/IS = O.loc
		if(IS.can_unequipitem())
			IS.unequipitem(src)
		else
			return
	src.equipitem(O)
	
/obj/screen/inventoryslot/proc/can_equipitem(obj/item/item)
	if(!src.fits_in_slot(item))
		return FALSE
	if(src.inventory)
		return FALSE
	if(!istype(item, /obj/item))
		return FALSE
	return TRUE

/obj/screen/inventoryslot/proc/equipitem(obj/item/item)
	src.inventory = item
	src.vis_contents = list(src.inventory)
	src.inventory.pixel_x = 0
	src.inventory.pixel_y = 0
	src.inventory.loc = src
	item.equipped = TRUE
	item.slot = src
	src.inventory_plane = item.plane
	item.plane = PLANE_SCREEN
	src.owner.inventory += item
	src.owner.update_icon()

/obj/screen/inventoryslot/proc/can_unequipitem()
	return TRUE

/obj/screen/inventoryslot/proc/unequipitem(atom/newloc)
	src.vis_contents = list()
	src.owner.inventory -= src.inventory
	src.inventory.equipped = FALSE
	src.inventory.slot = null
	src.inventory.plane = src.inventory_plane
	src.inventory = null
	src.owner.update_icon()

/obj/screen/inventoryslot/proc/fits_in_slot(atom/A)
	if (!istype(A,/obj/item))
		return FALSE
	else
		var/obj/item/I = A
		return src.slot_name in I.slots
