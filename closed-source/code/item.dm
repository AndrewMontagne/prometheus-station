/**
Parent type for all items that can be picked up
**/
/item
	parent_type = /obj
	mouse_over_pointer = MOUSE_HAND_POINTER
	var/item_state = "item"

/item/MouseDown(location,control,params)
	var/icon/I = new(icon, icon_state)
	I.Scale(64, 64)
	I.Blend(rgb(0,0,0,100),ICON_SUBTRACT)
	mouse_drag_pointer = I
	return ..(location,control,params)
