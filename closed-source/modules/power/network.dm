
/obj/structure/network_node/power
	node_kind = NET_KIND_POWER
	icon = 'assets/cc-by-sa-nc/icons_new/obj/network/cable.dmi'

/datum/network/power
	var/joule_buffer = MEGAJOULES(1)
	var/joules_consumed = 0
	var/joules_consumed_last = 0
	var/joules_provided = 0
	var/joules_provided_last = 0
	var/list/obj/machine/power_providers = list()

/datum/network/power/process()
	src.joules_consumed_last = src.joules_consumed
	src.joules_consumed = 0

/// Can we consume this much energy from the network?
/datum/network/power/proc/energy_available(var/joules)
	return src.joule_buffer >= joules

/// Attempts to consume a given amount of energy from the network, returns the amount we could get.
/datum/network/power/proc/consume_energy(var/joules)
	var/consumed = joules
	if (joules > src.joule_buffer)
		consumed = src.joule_buffer
	
	src.joules_consumed += consumed
	src.joule_buffer -= consumed
	
	return consumed


	

	

