/// A mixture of given reagents
/datum/chem/mixture
	var/total_moles			= 0
	var/container_volume 	= LITRES(1)

/**
* This is a data structure that maps the key of the reagent to the
* number of moles, and the temperature
**/
/datum/chem/mixture/var/list/reagents = list()

/datum/chem/mixture/proc/recalculate()

/// Calculates the solid/liquid volume of the mixture
/datum/chem/mixture/proc/volume()
