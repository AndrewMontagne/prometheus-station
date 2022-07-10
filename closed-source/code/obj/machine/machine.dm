
VAR_GLOBAL(list/all_machines) = list()

/// Machines - Objects that perform periodic processing and require power
/obj/machine
	parent_type = /obj/structure
	needs_init = TRUE
	var/idle_power = WATTS(0)
	var/power_on = FALSE

/obj/machine/proc/process()
	var/area/A = src.find_turf().loc
	var/obj/machine/power/apc/APC = A.apc
	if (!isnull(APC))
		var/power = APC.draw_apc_power(src.idle_power)
		if (power >= src.idle_power)
			if (src.power_on == FALSE)
				src.on_powerup()
		else if (src.power_on)
			src.on_powerdown()

/obj/machine/proc/on_powerup()
	src.power_on = TRUE

/obj/machine/proc/on_powerdown()
	src.power_on = FALSE

/obj/machine/New()
	. = ..()
	GLOBALS.all_machines.Add(src)

/obj/machine/Del()
	GLOBALS.all_machines.Remove(src)
	. = ..()
