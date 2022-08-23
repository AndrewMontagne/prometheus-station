/// A mixture of given reagents
/datum/chem/mixture
	var/list/reagents
	var/total_moles

/datum/chem/mixture/proc/recalculate()

/// Calculates the solid/liquid volume of the mixture
/datum/chem/mixture/proc/volume()
