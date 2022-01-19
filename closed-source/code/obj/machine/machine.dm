
var/global/list/global_all_machines = list()

/// Machines - Objects that perform periodic processing and require power
/obj/machine
	parent_type = /obj/structure
	needs_init = TRUE

/obj/machine/proc/process()

/obj/machine/New()
	. = ..()
	global_all_machines.Add(src)

/obj/machine/Del()
	global_all_machines.Remove(src)
	. = ..()
