
var/global/datum/scheduler/scheduler = null

/datum/scheduler
	var/list/queues

/datum/scheduler/New()
	if (!isnull(scheduler))
		CRASH("Initialising the scheduler twice!")
	scheduler = src

	src.queues = list(list(),list(),list(),list())

	spawn(1)
		tick()

/// The actual ticker
/datum/scheduler/proc/tick()
	set background = TRUE
	
	var/stop = FALSE
	stop = src.process_queue(src.queues[PRIORITY_REALTIME], FALSE)
	if (!stop)
		stop = src.process_queue(src.queues[PRIORITY_HIGH])
	if (!stop)
		stop = src.process_queue(src.queues[PRIORITY_MEDIUM], TRUE, TRUE, TRUE)
	if (!stop)
		src.process_queue(src.queues[PRIORITY_LOW], TRUE, TRUE)

	spawn(1)
		tick()

/// Process a specific queue
/datum/scheduler/proc/process_queue(list/queue, var/allow_yield = TRUE, var/only_if_time = FALSE, var/debt = FALSE)
	for (var/C in queue)
		var/controller/controller = C

		// Only trigger if it needs to be fired
		if (controller.next_fire_time < world.time)
			var/ticks_used = world.tick_usage / 100
			var/ticks_left = max(1 - ticks_used, 0)

			// Medium/low priority tasks are only scheduled if there is time
			if (only_if_time)
				var/projected_time = ticks_used + controller.average_ticks
				if (projected_time > 0.9)
					// Medium priority tasks can accrue runtime debt and be periodically executed
					if (debt)
						if (controller.tick_debt < controller.average_ticks)
							controller.tick_debt += ticks_left
							return FALSE
					else
						return FALSE

			src.process_controller(controller)

			// If it yielded, terminate queue processing
			if (allow_yield && controller.yielded)
				return TRUE

/// Process a specific controller
/datum/scheduler/proc/process_controller(controller/controller)
	controller.tick_debt = 0
	var/start = world.time + (world.tick_usage / 100)
	controller.process()
	var/ticks = ((world.time + (world.tick_usage / 100)) - start)

	if (controller.average_ticks == 0)
		controller.average_ticks = ticks
	else
		controller.average_ticks = (controller.average_ticks * 0.9) + (ticks * 0.1)

/// Add a controller with the appropriate priority
/datum/scheduler/proc/add_controller(controller/C)
	var/list/queue = src.queues[C.priority]
	queue.Add(C)
