/client
	fps = 60
	var/list/atom/ui
	var/_screen_dirty = FALSE

/client/proc/change_mob(mob/new_mob)
	src.mob.on_lose_client()
	src.mob = new_mob
	new_mob.on_gain_client()

/client/New()
	. = ..()
	LOG_INFO("[src.key] connected!")
	src.ui = list(src.get_parallax())
	src.rebuild_screen()
	src.init_infobrowser()


/// We use this instead 
/client/proc/rebuild_screen()
	if (src._screen_dirty == FALSE)
		src._screen_dirty = TRUE
		spawn(1)
			var/list/tmp_screen = list()
			tmp_screen |= src.ui
			tmp_screen |= src.mob.ui
			while (null in tmp_screen)
				tmp_screen.Remove(null)
			src.screen = tmp_screen
			src._screen_dirty = FALSE

/client/Del()
	. = ..()
	LOG_INFO("[src.key] disconnected!")
