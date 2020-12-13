/// Controller class
/controller
	parent_type = /datum
	var/next_fire_time = 0
	var/priority = PRIORITY_MEDIUM
	var/average_ticks = 0
	var/yielded = FALSE
	var/tick_debt = 0

/controller/proc/process()
	src.yielded = FALSE

/// Yields if we've almost used up the tick
/controller/proc/yield()
	if (world.tick_usage > 90)
		src.yielded = TRUE
		sleep(1)


