/mob/player/
	/// The items in the player's inventory
	var/list/obj/item/inventory = list()
	/// The inventory slots that this player has
	var/list/obj/screen/inventoryslot/invslots = list()
	/// The toolbars on the left of the screen denoting slots and sub-slots
	var/list/obj/screen/toolbar/slot_toolbars = list()
	/// Are we currently updating the slot toolbars?
	var/_updating_slot_toolbars = FALSE

/// Statelessly rebuild the list containing the player's inventory
/mob/player/proc/rebuild_inventory()
	var/list/obj/item/new_inventory = list()

	for (var/name in src.invslots)
		var/obj/screen/inventoryslot/I = src.invslots[name]
		new_inventory |= src._recursive_inventory_search(I)

	// TODO? determine deltas and fire events??

	src.inventory = new_inventory
	return new_inventory

/// Builds the slot toolbars from scratch
/mob/player/proc/build_slot_toolbars()
	var/list/obj/screen/toolbar/toolbars = list()
	for (var/slotname in src.invslots)
		var/obj/screen/inventoryslot/S = src.invslots[slotname]
		if (istype(S, /obj/screen/inventoryslot/hand))
			continue
		var/obj/screen/toolbar/T = new /obj/screen/toolbar(src.slot_toolbar, list(S), TRUE)
		slot_toolbars[slotname] = T
		toolbars.Add(T)
	src.update_slot_toolbars()
	return toolbars

/// Updates the slot toolbars in response to an inventory change, so subslots are updated
/mob/player/proc/update_slot_toolbars()
	if (src._updating_slot_toolbars)
		return
	else
		src._updating_slot_toolbars = TRUE
		spawn(0)
			for (var/slotname in src.slot_toolbars)
				var/obj/screen/toolbar/T = src.slot_toolbars[slotname]
				var/obj/screen/inventoryslot/S = src.invslots[slotname]
				for (var/obj/screen/SC in T.screens)
					if (SC == S)
						continue
					else
						T.remove_screen(SC)

				if (S.inventory)
					for (var/obj/screen/SC in S.inventory.internal_slots)
						T.add_screen(SC)
			src._updating_slot_toolbars = FALSE

/// Returns a list of all items in a given inventory slot, including nested subslots.
/mob/player/proc/_recursive_inventory_search(var/obj/screen/inventoryslot/I)
	var/list/inv_items = list()
	if (istype(I.inventory, /obj/item))
		inv_items.Add(I.inventory)
		for (var/obj/screen/inventoryslot/IN in I.inventory.internal_slots)
			inv_items |= src._recursive_inventory_search(inv_items, IN)
	return inv_items

/// Returns what is in a given inventory slot, or null.
/mob/player/proc/inv(slotname as text)
	if(slotname in src.invslots)
		var/obj/screen/inventoryslot/IS = src.invslots[slotname]
		return IS.inventory
	else
		return null

/// Sets the contents of an inventory slot to an item, unequipping it from the previous slot, if any. Returns whether it succeeded.
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

/// Attempts to equip a given item in any free slot. Returns whether it succeeded.
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

/**
Inventory Slots

A UI element that represents an inventory slot such as hands, clothes, etc. It can contain nested slots to represent things like pockets.
**/
/obj/screen/inventoryslot
	name = SLOT_POCKET
	var/atom/owner = null
	var/obj/item/inventory = null
	var/inventory_plane = 0
	var/slot_name = SLOT_POCKET
	var/background = "background"
	icon = 'assets/cc-by-sa-nc/icons/ui/screen_midnight.dmi'
	icon_state = SLOT_POCKET
	layer = -1

/obj/screen/inventoryslot/New(atom/M)
	. = ..()
	if (istype(M, /mob/player))
		var/mob/player/P = M
		P.invslots[src.slot_name] = src
	src.owner = M
	underlays.Add(src.background)

/// Handler for when an inventory item is dropped onto the slot
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
	
/// Returns whether this slot can equip a given item. Don't override this, override [/obj/screen/inventoryslot/proc/fits_in_slot] instead.
/obj/screen/inventoryslot/proc/can_equipitem(obj/item/item)
	if(!src.fits_in_slot(item))
		return FALSE
	if(src.inventory)
		return FALSE
	if(!istype(item, /obj/item))
		return FALSE
	return TRUE

/// Equips a given item. Performs no checks, intended to be called by other functions that do check.
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
	if (src.owner)
		if (istype(src.owner, /mob/player))
			var/mob/player/P = src.owner
			P.rebuild_inventory()
			P.update_icon()
			P.update_slot_toolbars()
	item.update_icon()

/// Can we UNequip a given item? (Think chinese finger traps)
/obj/screen/inventoryslot/proc/can_unequipitem()
	return TRUE

/obj/screen/inventoryslot/proc/unequipitem(atom/newloc)
	src.vis_contents = list()
	src.inventory.equipped = FALSE
	src.inventory.slot = null
	src.inventory.plane = src.inventory_plane
	src.inventory.loc = newloc
	src.inventory.update_icon()
	src.inventory = null
	if (src.owner)
		if (istype(src.owner, /mob/player))
			var/mob/player/P = src.owner
			P.rebuild_inventory()
			P.update_icon()
			P.update_slot_toolbars()

/// Does a this item fit in this slot? Intended to be overriden for custom behaviour.
/obj/screen/inventoryslot/proc/fits_in_slot(atom/A)
	if (!istype(A,/obj/item))
		return FALSE
	else
		var/obj/item/I = A
		return src.slot_name in I.slots
