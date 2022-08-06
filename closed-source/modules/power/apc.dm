/area/var/obj/machine/power/apc/apc

/// Area power controller
/obj/machine/power/apc
	name = "area power controller"
	var/apc_charge = JOULES(0)
	var/apc_charge_max = KILOJOULES(10)
	var/max_charge_rate = KILOWATTS(1)
	var/consumed = 0
	var/consumed_last = 0
	icon = 'assets/cc-by-sa-nc/icons_new/obj/machine/apc.dmi'
	icon_state = "apc"
	density = FALSE

	var/display_state = "charging"
	
/obj/machine/power/apc/Initialise()
	. = ..()
	var/turf/T = src.find_turf()
	var/area/A = T.loc
	if (!isnull(A.apc))
		LOG_ERROR("Duplicate apc for [A.name]")
	else
		A.apc = src
		src.apc_charge = src.apc_charge_max
		src.name = "[A.name] apc"

/obj/machine/power/apc/process()
	. = ..()

	src.consumed_last = src.consumed
	src.consumed = 0

	if (isnull(src.connected_node))
		if (src.connect_to_node() == FALSE)
			if (src.apc_charge < 10)
				src.display_state = "none"
			else
				src.display_state = "discharging"
			src.update_icon()
			return

	if (src.apc_charge < src.apc_charge_max)
		var/datum/network/power/N = src.connected_node.network
		var/desired_charge = src.apc_charge_max - src.apc_charge
		if (desired_charge > src.max_charge_rate)
			desired_charge = src.max_charge_rate
		var/charge_amount = 0
		if (!isnull(N))
			charge_amount = N.consume_energy(desired_charge)
		var/previous_charge = src.apc_charge
		src.apc_charge += charge_amount

		if (src.apc_charge < 10)
			src.display_state = "none"
		else if (src.apc_charge == src.apc_charge_max)
			src.display_state = "charged"
		else if (previous_charge < src.apc_charge)
			src.display_state = "charging"
		else
			src.display_state = "discharging"
	else
		src.display_state = "charged"

	src.update_icon()

/obj/machine/power/apc/update_icon()
	. = ..()
	src.overlays += src.display_state

/obj/machine/power/apc/proc/draw_apc_power(var/amount)
	var/consumed = amount
	if (src.apc_charge < amount)
		consumed = src.apc_charge

	src.apc_charge -= consumed
	src.consumed += consumed

	return consumed
		


