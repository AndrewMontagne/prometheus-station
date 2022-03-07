/// Statelessly updates the player's icon.
/mob/player/update_icon()
	. = ..()
	src.update_clothing()

/// Intended to be called by [/mob/player/proc/update_icon], adds all the inventory overlays for a player.
/mob/player/proc/update_clothing()
	// TODO: Composite non-hand slots into a single image and cache it in the rsc?
	for(var/slotname in src.invslots)
		var/obj/screen/inventoryslot/slot = src.invslots[slotname]
		if(!(slot.inventory))
			continue
		slot.inventory.add_worn_overlays(src, slot.slot_name)
	return

/// The vertical offset for a given slot, for taller or shorter species
/mob/player/proc/clothing_offset_for_slot(var/slot)
	return 0

/// The icon state of the overlay
/obj/item/var/worn_overlay_state = null

/// Add the overlays to the player M, given the provided inventory slot
/obj/item/proc/add_worn_overlays(var/mob/player/M, var/slot)
	var/state = "[item_state]_[slot]"
	worn_overlay_state = state

	if(state in icon_states(icon))
		var/image/I = image("icon" = icon, "icon_state" = state, "layer" = MOB_LAYER)

		I.pixel_y = M.clothing_offset_for_slot(slot)
		M.overlays += I
