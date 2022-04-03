/obj/machine/test
	name = "test machine"
	icon = 'assets/cc-by-sa-nc/icons/obj/pipes/disposal.dmi'
	icon_state = "disposal"
	var/datum/simple_ui/themed/nano/ui

/obj/machine/test/Initialise()
	. = ..()
	ui = new /datum/simple_ui/themed/nano(src, 330, 190, "disposal_bin")
	ui.auto_refresh = TRUE
	ui.can_resize = FALSE

/obj/machine/test/sui_data(mob/user)
	var/list/data = list()
	data["flush"] = ui.act("Engage", user, "handle-1")
	data["full_pressure"] = "Ready"
	data["pressure_charging"] = ui.act("Turn Off", user, "pump-0", class="active", disabled=FALSE)
	var/per = rand(100)
	data["per"] = "[round(per, 1)]%"
	data["contents"] = ui.act("Eject Contents", user, "eject", disabled=contents.len < 1)
	data["isai"] = FALSE
	return data

/obj/machine/test/HelpClick(mob/holder, atom/item, list/params)
	. = ..()
	ui.render(holder)
