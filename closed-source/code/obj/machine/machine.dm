/// Machines - Onjects that perform periodic processing and require power

var/global/list/global_all_machines = list()

/obj/machine
	needs_init = TRUE

/obj/machine/proc/process()

/obj/machine/New()
	. = ..()
	global_all_machines.Add(src)

/obj/machine/Del()
	global_all_machines.Remove(src)
	. = ..()
