/// A mixture of given reagents
/datum/chem/mixture
	var/total_moles			= 0
	var/container_volume 	= LITRES(1)

	/**
	* This is a data structure that maps the key of the reagent to the
	* number of moles, and the temperature
	**/
	var/list/reagents = list()

/datum/chem/mixture/New(var/volume, var/list/new_reagents)
	. = ..()
	src.container_volume = volume
	src.reagents = new_reagents

/// Calculates the solid/liquid volume of the mixture
/datum/chem/mixture/proc/volume()

/datum/chem/mixture/proc/pressure()
	var/pressure = PA(0)

	for (var/key in src.reagents)
		var/datum/chem/reagent/R = GLOBALS.atmoschem_controller.reagents[key]
		var/list/data = src.reagents[key]
		var/partial_pressure = R.gas_pressure(data[1], data[2], src.container_volume)
		pressure += partial_pressure
	
	return pressure

/// Based upon the reagents in the mixture, return the possible reactions
/datum/chem/mixture/proc/potential_reactions()
	src.reagents = sortList(src.reagents)
	var/key = src.reagents.Join("-")

	VAR_STATIC(list/cached_reactions) = list()

	if (key in cached_reactions)
		return cached_reactions[key]
