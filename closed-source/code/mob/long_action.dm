/mob/
	VAR_PRIVATE/_performing_long_action = FALSE
	VAR_PRIVATE/_long_action_interruped = FALSE

/mob/proc/can_perform_long_action()
	return !src._performing_long_action

/mob/proc/interrupt_long_action()
	src._long_action_interruped = TRUE

/mob/proc/perform_long_action(var/duration)
	if (!src.can_perform_long_action())
		return FALSE
		
	src._long_action_interruped = FALSE
	src._performing_long_action = TRUE
	var/target_time = world.time + duration
	
	while (world.time < target_time)
		if (src._long_action_interruped)
			src._performing_long_action = FALSE
			return FALSE
		sleep(1)

	src._performing_long_action = FALSE
	return TRUE

/mob/Move(NewLoc, Dir, step_x, step_y)
	. = ..()
	src.interrupt_long_action()

