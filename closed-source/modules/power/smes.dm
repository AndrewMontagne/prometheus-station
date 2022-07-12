/obj/machine/power/smes
	var/input_amount = MEGAWATTS(1)
	var/input_direction = SOUTH
	var/output_amount = MEGAWATTS(1)
	var/internal_storage_amount = MEGAJOULES(2)
	var/internal_storage_max = MEGAJOULES(10)
	var/consumed_last = 0
	var/state = "smes-charging"
	icon = 'assets/cc-by-sa-nc/icons_new/obj/machine/provider.dmi'
	icon_state = "smes"
	var/datum/simple_ui/themed/nano/ui

/obj/machine/power/smes/Initialise()
	. = ..()
	ui = new /datum/simple_ui/themed/nano(src, 330, 190, "smes")
	ui.auto_refresh = TRUE
	ui.can_resize = FALSE

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
		src.consumed_last = supplied_joules
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


/// UI STUFF

/obj/machine/power/smes/sui_data(mob/user)
	var/list/data = list()
	switch (src.state)
		if ("smes-charging")
			data["state"] = "Charging"
		if ("smes-discharging")
			data["state"] = "Discharging"
		if ("smes-error")
			data["state"] = "ERROR!"
	var/per = (src.internal_storage_amount / src.internal_storage_max) * 100
	data["per"] = "[round(per, 1)]%"
	data["battery"] = "[unitize(src.internal_storage_amount, "J")] / [unitize(src.internal_storage_max, "J")]"
	data["input"] = "[unitize(src.consumed_last, "W")] / [unitize(src.input_amount, "W")]"
	data["output"] = "[unitize(src.joules_output_last, "W")] / [unitize(src.output_amount, "W")]"
	return data

/obj/machine/power/smes/HelpClick(mob/holder, atom/item, list/params)
	. = ..()
	ui.render(holder)


