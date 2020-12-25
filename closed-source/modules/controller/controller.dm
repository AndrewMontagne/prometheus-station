
//! Controller Base Class
/**
All controllers inherit from this
**/
/controller
	parent_type = /datum
	var/name = ""
	var/next_fire_time = 0
	var/priority = PRIORITY_MEDIUM
	var/average_ticks = 0
	var/yielded = FALSE
	var/tick_debt = 0
	var/tick_rate = 10

/// Called every `src.tick_rate` ticks
/controller/proc/process()
	SHOULD_CALL_PARENT(TRUE)
	src.yielded = FALSE
	src.next_fire_time = world.time + src.tick_rate

/// Yields if we've almost used up the tick
/controller/proc/yield()
	if (world.tick_usage > 90)
		src.yielded = TRUE
		sleep(1)


