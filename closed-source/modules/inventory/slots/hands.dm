
/obj/screen/inventoryslot/hand

/obj/screen/inventoryslot/hand/fits_in_slot(obj/item/I)
	return TRUE

/obj/screen/inventoryslot/hand/right
	icon_state = "hand_r"
	slot_name = SLOT_RIGHT_HAND
	screen_loc = "CENTER:-16,2"

/obj/screen/inventoryslot/hand/left
	icon_state = "hand_l"
	slot_name = SLOT_LEFT_HAND
	screen_loc = "CENTER:16,2"

/obj/screen/drop_from_hand
	icon_state = "act_drop"
	icon = 'assets/cc-by-sa-nc/icons/ui/screen_midnight.dmi'
	width = 16

/obj/screen/craft
	icon_state = "craft"
	icon = 'assets/cc-by-sa-nc/icons/ui/screen_midnight.dmi'
	width = 16
	height = 16
