/**
Parent type for all items that can be picked up
**/
/obj/item
	mouse_over_pointer = MOUSE_HAND_POINTER
	var/item_state = "item"
	var/list/slots = list()
	var/list/obj/screen/inventoryslot/internal_slots = list()
	var/equipped = FALSE
	var/obj/screen/inventoryslot/slot = null

/obj/item/New()
	. = ..()
	item_state = icon_state

/obj/item/MouseDown(location,control,params)
	var/icon/I = new(icon, icon_state)
	I.Scale(64, 64)
	I.Blend(rgb(0,0,0,100),ICON_SUBTRACT)
	mouse_drag_pointer = I
	return ..(location,control,params)

/obj/item/HelpClick(mob/source, atom/item, list/params)
	if (istype(source, /mob/player) && item == source)
		var/mob/player/P = source
		var/obj/screen/inventoryslot/hand/active_hand = P.get_active_hand()
		if (src.Adjacent(source))
			if (active_hand.can_equipitem(src))
				active_hand.equipitem(src)

/// Default method for clicking something with an item.
/obj/item/proc/UseOn(mob/holder, atom/target, list/params)
	// NOOP
