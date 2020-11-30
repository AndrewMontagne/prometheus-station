/client/proc/change_mob(mob/new_mob)
	src.mob.on_lose_client()
	src.mob = new_mob
	src.mob.on_gain_client()

/client/New()
	. = ..()
	LOG_INFO("[src.key] connected!")

/client/Del()
	. = ..()
	LOG_INFO("[src.key] disconnected!")
