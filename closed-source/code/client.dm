/client
	fps = 30

/client/proc/change_mob(mob/new_mob)
	src.mob.on_lose_client()
	src.mob = new_mob
	src.mob.on_gain_client()

/client/New()
	. = ..()
	LOG_INFO("[src.key] connected!")
	src.screen += src.get_parallax()
	src.init_infobrowser()

/client/Del()
	. = ..()
	LOG_INFO("[src.key] disconnected!")

/client/Click(object, location, control, params)
	var/list/parameters = params2list(params)
	var/result = src.mob.HandleClick(object, location, control, parameters)
	if (result)
		. = ..()

/client/DblClick(object, location, control, params)
	var/list/parameters = params2list(params)
	var/result = src.mob.HandleDoubleClick(object, location, control, parameters)
	if (result)
		. = ..()
