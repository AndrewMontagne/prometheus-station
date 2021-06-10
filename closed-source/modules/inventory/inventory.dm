/mob/player/update_icon()
	. = ..()
	
	src.update_clothing()

/mob/player/proc/update_clothing()
	// TODO: Composite non-hand slots into a single image and cache it in the rsc?

	for(var/obj/screen/inventoryslot/slot in src.invslots)
		if(!(slot.inventory))
			continue
		slot.inventory.add_worn_overlays(src, slot.slot_name)
	return

/mob/player/proc/clothing_offset_for_slot(/var/slot)
	return 0

/item/var/worn_overlay_state = null

/item/proc/add_worn_overlays(var/mob/player/M, var/slot)
	var/state = "[item_state]-[slot]"
	worn_overlay_state = state

	if(state in icon_states(icon))
		var/image/I = image("icon" = icon, "icon_state" = state, "layer" = MOB_LAYER)

		I.pixel_y = M.clothing_offset_for_slot(slot)
		M.overlays += I
