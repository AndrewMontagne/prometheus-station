/area/var/obj/machine/power/apc/apc

/// Area power controller
/obj/machine/power/apc
	var/apc_charge = JOULES(0)
	var/apc_charge_max = KILOJOULES(10)
	var/consumed = 0
	var/consumed_last = 0
	icon = 'assets/cc-by-sa-nc/icons/obj/pipes/disposal.dmi'
	icon_state = "disposal"
	
/obj/machine/power/apc/Initialise()
	. = ..()
	var/turf/T = src.find_turf()
	var/area/A = T.loc
	A.apc = src

/obj/machine/power/apc/process()
	. = ..()

	src.consumed_last = src.consumed
	src.consumed = 0

	if (isnull(src.connected_node))
		if (src.connect_to_node() == FALSE)
			return

	if (src.apc_charge < src.apc_charge_max)
		var/datum/network/power/N = src.connected_node.network
		src.apc_charge += N.consume_energy(src.apc_charge_max - src.apc_charge)

/obj/machine/power/apc/proc/consume_energy(var/amount)
	var/consumed = amount
	if (src.apc_charge < amount)
		consumed = src.apc_charge

	src.apc_charge -= consumed
	src.consumed += consumed

	return consumed
		


