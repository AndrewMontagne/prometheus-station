/client
	fps = 60

/client/proc/change_mob(mob/new_mob)
	src.mob.on_lose_client()
	src.mob = new_mob
	new_mob.on_gain_client()

/client/New()
	. = ..()
	LOG_INFO("[src.key] connected!")
	src.screen += src.get_parallax()
	src.init_infobrowser()
	src.init_map_panes()

/client/Del()
	. = ..()
	LOG_INFO("[src.key] disconnected!")
