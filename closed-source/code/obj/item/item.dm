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

/obj/item/HelpDoubleClick(mob/source, list/params)

	if (istype(source, /mob/player))
		var/mob/player/P = source
		P.tryequip(src)
