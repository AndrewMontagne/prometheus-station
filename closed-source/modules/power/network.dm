
/obj/structure/network_node/power
	node_kind = NET_KIND_POWER
	icon = 'assets/cc-by-sa-nc/icons_new/obj/network/cable.dmi'

/datum/network/power
	var/joules_consumed = 0
	var/joules_consumed_last = 0
	var/list/obj/machine/power_providers = list()

/datum/network/power/process()
	src.joules_consumed_last = src.joules_consumed
	src.joules_consumed = 0

	shuffle_list(src.power_providers)

/// Can we consume this much energy from the network?
/datum/network/power/proc/energy_available(var/joules)
	var/total_available = 0
	for (var/provider in src.power_providers)
		var/obj/machine/power/P = provider
		total_available += P.joule_output_buffer
	return total_available

/// Attempts to consume a given amount of energy from the network, returns the amount we could get.
/datum/network/power/proc/consume_energy(var/joules)
	var/available = src.energy_available()
	if (joules > available)
		joules = available
	
	var/consumed = 0
	for (var/provider in src.power_providers)
		var/obj/machine/power/P = provider
		if (P.joule_output_buffer == 0)
			continue
		var/supplied = P.consume_energy(joules)
		joules -= supplied
		consumed += supplied
		if (joules == 0)
			break

	return consumed

/datum/network/power/on_node_remove(obj/structure/network_node/node)
	. = ..()
	// Make sure after the node removal, power_providers is a subset of connected_devices
	src.power_providers &= src.connected_devices

/datum/network/power/on_device_add(obj/machine/M)
	. = ..()
	if (istype(M, /obj/machine/power))
		src.power_providers.Add(M)
	
/datum/network/power/on_device_remove(obj/machine/M)
	. = ..()
	if (istype(M, /obj/machine/power))
		src.power_providers.Remove(M)

	

