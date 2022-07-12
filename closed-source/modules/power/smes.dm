/obj/machine/power/smes
	var/input_amount = MEGAWATTS(1)
	var/input_direction = SOUTH
	var/output_amount = MEGAWATTS(1)
	var/internal_storage_amount = MEGAWATTS(2)
	var/internal_storage_max = MEGAWATTS(10)
	var/state = "smes-charging"
	icon = 'assets/cc-by-sa-nc/icons_new/obj/machine/provider.dmi'
	icon_state = "smes"

/obj/machine/power/smes/Initialise()
	. = ..()

/obj/machine/power/smes/process()
	. = ..()

	var/start_buffer = src.internal_storage_amount
	
	if (isnull(src.connected_node))
		src.connect_to_node()
	
	var/amount_to_output = src.output_amount - src.joule_output_buffer
	if (amount_to_output > src.internal_storage_amount)
		amount_to_output = src.internal_storage_amount

	src.joules_output += amount_to_output
	src.joule_output_buffer += amount_to_output
	src.internal_storage_amount -= amount_to_output

	var/turf/candidate_turf = get_step(src.loc, src.input_direction)
	var/inverted_dir = INVERT_DIR_MAP[src.input_direction]

	var/datum/network/power/net = null
	
	for (var/obj/structure/network_node/power/C in candidate_turf)
		if ("[inverted_dir]" in C.dirs)
			net = C.network
			break

	if (!isnull(net))
		var/needed_joules = src.internal_storage_max - src.internal_storage_amount
		var/supplied_joules = net.consume_energy(needed_joules)
		src.internal_storage_amount += supplied_joules
		if (src.internal_storage_amount < start_buffer)
			src.state = "smes-discharging"
		else
			src.state = "smes-charging"
	else
		src.state = "smes-err"

	src.update_icon()

/obj/machine/power/smes/update_icon()
	. = ..()
	src.overlays += src.state

	var/percent = src.internal_storage_amount / src.internal_storage_max
	var/level = round(percent * 6) + 1
	src.overlays += "smes-og[level]"

