/datum/proc/sui_canview(mob/user)
	return TRUE

/datum/proc/sui_getcontent(mob/user)
	return "Default Implementation"

/datum/proc/sui_canuse(mob/user)
	return src.sui_canview(user)

/datum/proc/sui_data(mob/user)
	return list()

/datum/proc/sui_data_debug(mob/user)
	return html_encode(json_encode(src.sui_data(user)))

/datum/proc/sui_act(mob/user, action, list/params)
	// No Implementation

/atom/sui_canview(mob/user)
	if(istype(user, /mob/lobby))
		return TRUE
	if(isturf(src.loc) && src.Adjacent(user))
		return TRUE
	return FALSE

/obj/item/sui_canview(mob/user)
	if(src.loc == user && istype(user, /mob/player))
		var/mob/player/P = user
		return src in P.inventory
	return ..()

/obj/machinery/sui_canview(mob/user)
	return ..()
