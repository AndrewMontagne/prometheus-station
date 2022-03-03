/// Inventory slot representing hands
/obj/screen/inventoryslot/hand
	var/is_active = FALSE

/obj/screen/inventoryslot/hand/New(atom/M)
	. = ..()
	src.update_icon()

/obj/screen/inventoryslot/hand/update_icon()
	. = ..()
	src.overlays.Cut()
	if (src.is_active)
		src.overlays += "hand_active"

/obj/screen/inventoryslot/hand/fits_in_slot(obj/item/I)
	return TRUE

/obj/screen/inventoryslot/hand/right
	is_active = TRUE
	icon_state = "hand_r"
	slot_name = SLOT_RIGHT_HAND
	screen_loc = "CENTER:-16,2"

/obj/screen/inventoryslot/hand/left
	icon_state = "hand_l"
	slot_name = SLOT_LEFT_HAND
	screen_loc = "CENTER:16,2"
