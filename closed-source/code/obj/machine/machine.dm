
VAR_GLOBAL(list/all_machines) = list()

/// Machines - Objects that perform periodic processing and require power
/obj/machine
	parent_type = /obj/structure
	needs_init = TRUE
	var/idle_power = WATTS(0)

/obj/machine/proc/process()
	var/area/A = src.find_turf().loc
	var/obj/machine/power/apc/APC = A.apc
	if (!isnull(APC))
		APC.consume_energy(src.idle_power)

/obj/machine/New()
	. = ..()
	GLOBALS.all_machines.Add(src)

/obj/machine/Del()
	GLOBALS.all_machines.Remove(src)
	. = ..()
