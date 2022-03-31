
VAR_GLOBAL(list/all_machines) = list()

/// Machines - Objects that perform periodic processing and require power
/obj/machine
	parent_type = /obj/structure
	needs_init = TRUE

/obj/machine/proc/process()

/obj/machine/New()
	. = ..()
	GLOBALS.all_machines.Add(src)

/obj/machine/Del()
	GLOBALS.all_machines.Remove(src)
	. = ..()
