/// A mixture of given reagents
/datum/chem/mixture
	var/total_moles			= 0
	var/container_volume 	= LITRES(1)

	/**
	* This is a data structure that maps the key of the reagent to the
	* number of moles, the temperature, and the phase of matter:
	*
	* "PHASE":
	*	"KEY":
	*	  - MOLES
	*	  - TEMPERATURE
	**/
	var/list/reagents = list()

/datum/chem/mixture/New(var/volume, var/list/new_reagents)
	. = ..()
	src.container_volume = volume
	src.reagents = new_reagents

/// Calculates the solid/liquid volume of the mixture
/datum/chem/mixture/proc/volume()
	var/volume = LITRES(0)

	for (var/phase in src.reagents)
		if (phase == PHASE_GAS) // Gases fill their entire volume, so any gas would make this meaningless
			continue
		var/list/reagents_by_phase = src.reagents[phase]
		for (var/key in reagents_by_phase)
			var/datum/chem/reagent/R = GLOBALS.atmoschem_controller.reagents[key]
			var/list/data = reagents_by_phase[key]
			var/partial_volume = R.fluid_volume(data[1], phase)
			volume += partial_volume

	return volume

/// Calculates the gas pressure of the mixture
/datum/chem/mixture/proc/pressure()
	var/pressure = PA(0)
	var/remaining_volume = clamp(src.container_volume - src.volume, MILLILITRES(0.1), src.container_volume)

	for (var/phase in src.reagents)
		if (phase != PHASE_GAS)
			continue
		var/list/reagents_by_phase = src.reagents[phase]
		for (var/key in reagents_by_phase)
			var/datum/chem/reagent/R = GLOBALS.atmoschem_controller.reagents[key]
			var/list/data = reagents_by_phase[key]
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
