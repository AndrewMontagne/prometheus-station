
/**
Controller Base Class

All controllers inherit from this
**/
/controller
	parent_type = /datum
	/// Name of the controller
	var/name = ""
	/// The `world.time` the controller will process next
	var/next_fire_time = 0
	/// The controller's priority, see [/datum/scheduler] for more details
	var/priority = PRIORITY_MEDIUM
	/// The computed average ticks this controller runs
	var/average_ticks = 0
	/// Has this controller yielded since it last fired?
	var/yielded = FALSE
	/// For PRIORITY_MEDIUM tasks, this is the accumulated execution debt
	var/tick_debt = 0 
	/// Interval in ticks that this controller fires in
	var/tick_rate = FRAMES_PER_SECOND

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


