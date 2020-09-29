/mob/Login()
	log_access("Login: [key_name(src)] from [src.client.address ? src.client.address : "localhost"]")
	src.lastKnownIP = src.client.address
	src.computer_id = src.client.computer_id
	world.update_status()

	if (!src.hud_used)
		src.hud_used = new/obj/hud( src )
	else
		del(src.hud_used)
		src.hud_used = new/obj/hud( src )

	src.next_move = 1
	src.sight |= SEE_SELF
	src.logged_in = 1
	..()
