
/// Global scheduler declaration
VAR_GLOBAL(datum/scheduler/scheduler) = null

//! Controller Task Scheduler
/**
This is a co-operatively multitasking task scheduler for controllers.

Controllers are run according to the following priorities:

- `PRIORITY_REALTIME` controllers are always executed first, and will overrun the tick.
- `PRIORITY_HIGH` controllers are executed until one of the controllers yields.
- `PRIORITY_MEDIUM` controllers are executed if the scheduler predicts there is time to,
and if there is not, they accrue "execution debt" so that they will eventually be
scheduled to be run.
- `PRIORITY_LOW` controllers are executed if there is time, but do not accrue debt.
**/
/datum/scheduler
	/// The controller queues. Each queue represents a priority level.
	var/list/queues = list(list(),list(),list(),list())

/datum/scheduler/New()
	if (!isnull(GLOBALS.scheduler))
		CRASH("Initialising the scheduler twice!")
	GLOBALS.scheduler = src

	spawn(1)
		tick()

/// The "ticker" - This calls itself repeatedly on an infinite loop
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
	PRIVATE_PROC(TRUE)

	// Sort the queue by when the next controller is due to fire
	queue = list_bubblesort(queue, "next_fire_time")

	for (var/C in queue)
		var/controller/controller = C

		// Only trigger if it needs to be fired
		if (controller.next_fire_time < world.time)
			var/ticks_used = world.tick_usage / 100
			var/ticks_left = max(1 - ticks_used, 0)
			var/time_since_last = (world.time - controller.next_fire_time)

			// Medium/low priority tasks are only scheduled if there is time, within reason
			if (only_if_time && time_since_last < SECONDS(10))
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
	PRIVATE_PROC(TRUE)

	controller.tick_debt = 0
	var/start = world.time + (world.tick_usage / 100)
	controller.process()
	var/ticks = ((world.time + (world.tick_usage / 100)) - start)

	controller.average_ticks = (controller.average_ticks * 0.9) + (ticks * 0.1)

/// Add a controller with the appropriate priority
/datum/scheduler/proc/add_controller(controller/C)
	var/list/queue = src.queues[C.priority]
	queue.Add(C)
