/obj/screen
  mouse_over_pointer = MOUSE_HAND_POINTER

/obj/item
  mouse_over_pointer = MOUSE_HAND_POINTER

/obj/item/MouseDown(location,control,params)
	var/icon/I = new(icon, icon_state)
	I.Scale(64, 64)
	I.Blend(rgb(0,0,0,100),ICON_SUBTRACT)
	mouse_drag_pointer = I
	return ..(location,control,params)

/obj/machinery
  mouse_over_pointer = MOUSE_HAND_POINTER

/obj/closet
  mouse_over_pointer = MOUSE_HAND_POINTER

/obj/secure_closet
  mouse_over_pointer = MOUSE_HAND_POINTER

/mob/
  mouse_over_pointer = MOUSE_HAND_POINTER
