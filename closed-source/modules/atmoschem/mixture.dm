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


/datum/chem/mixture/proc/test(var/moles)
	src.add_reagents(list(PHASE_GAS = list("co2" = list(ATMOSCHEM_MOLES = moles, ATMOSCHEM_TEMP = CELSIUS(9999)))))


/// Simulates the mixture, performing all relevant calculations
/datum/chem/mixture/proc/simulate()
	src.adjust_thermal_energy(0)
	

/// Adjusts the thermal energy of the mixture
/datum/chem/mixture/proc/adjust_thermal_energy(var/joules = 0, var/phases = null)
	if (isnull(phases))
		phases = ALL_PHASES

	for (var/phase in phases)
		var/list/reagents_by_phase = src.reagents[phase]
		if (isnull(reagents_by_phase))
			continue
		var/total_therm_energy = 0
		var/total_specific_capacity = 0
		for (var/key in reagents_by_phase)
			var/list/data = reagents_by_phase[key]
			if (isnull(data))
				continue
			var/datum/chem/reagent/R = GLOBALS.atmoschem_controller.reagents[key]
			total_therm_energy += R.thermal_energy(data[ATMOSCHEM_TEMP], data[ATMOSCHEM_MOLES], phase)
			total_specific_capacity += R.thermal_energy(KELVINS(100), data[ATMOSCHEM_MOLES], phase)

		for (var/key in reagents_by_phase)
			var/list/data = reagents_by_phase[key]
			if (isnull(data))
				continue
			var/datum/chem/reagent/R = GLOBALS.atmoschem_controller.reagents[key]
			var/specific_capacity = R.thermal_energy(KELVINS(100), data[ATMOSCHEM_MOLES], phase)
			var/ratio = specific_capacity / total_specific_capacity
			var/temp = R.temperature(total_therm_energy * ratio, data[ATMOSCHEM_MOLES], phase)
			src.reagents[phase][key][ATMOSCHEM_TEMP] = temp


/// Adds reagents to the mixture, takes the same data structure defined in [/datum/chem/mixture/var/reagents]
/datum/chem/mixture/proc/add_reagents(var/list/reagent_data)
	for (var/phase in reagent_data)
		if (islist(src.reagents[phase]) == FALSE)
			src.reagents[phase] = list()

		var/list/reagents_by_phase = reagent_data[phase]
		for (var/key in reagents_by_phase)
			if (islist(src.reagents[phase][key]) == FALSE)
				src.reagents[phase][key] = list(ATMOSCHEM_MOLES = 0, ATMOSCHEM_TEMP = 0)
			var/total_moles = src.reagents[phase][key][ATMOSCHEM_MOLES] + reagents_by_phase[key][ATMOSCHEM_MOLES]
			var/total_therm_energy = (src.reagents[phase][key][ATMOSCHEM_MOLES] * src.reagents[phase][key][ATMOSCHEM_TEMP]) + (reagents_by_phase[key][ATMOSCHEM_MOLES] * reagents_by_phase[key][ATMOSCHEM_TEMP])
			var/new_temp = total_therm_energy / total_moles
			src.reagents[phase][key][ATMOSCHEM_MOLES] = total_moles
			src.reagents[phase][key][ATMOSCHEM_TEMP] = new_temp


/// Removes reagents from the mixture, returns the same data structure as defined in [/datum/chem/mixture/var/reagents]
/datum/chem/mixture/proc/remove_moles(var/moles, var/list/phases = null)
	if (isnull(phases))
		phases = ALL_PHASES

	var/list/result = list()
	var/total_moles = src.total_moles(phases)

	for (var/phase in phases)
		var/list/phase_result = list()
		var/list/reagents_by_phase = src.reagents[phase]
		for (var/key in reagents_by_phase)
			var/list/data = reagents_by_phase[key]
			if (isnull(data))
				continue
			var/reagent_moles_ratio = data[ATMOSCHEM_MOLES] / total_moles

			var/moles_to_remove = reagent_moles_ratio * moles
			if (moles_to_remove > data[ATMOSCHEM_MOLES])
				moles_to_remove = data[ATMOSCHEM_MOLES]

			phase_result[key] =  list(moles_to_remove, data[ATMOSCHEM_TEMP]) // Moles, Temp
			src.reagents[phase][key][ATMOSCHEM_MOLES] -= moles_to_remove

			// If we have removed all the reagent, remove the association
			if (src.reagents[phase][key][ATMOSCHEM_MOLES] <= 0)
				src.reagents[phase][key] = null

		result[phase] = phase_result
	return result
			

/// Calulates the total number of moles in a mixture
/datum/chem/mixture/proc/total_moles(var/list/phases = null)
	if (isnull(phases))
		phases = ALL_PHASES

	var/moles = 0
	for (var/phase in phases)
		var/list/reagents_by_phase = src.reagents[phase]
		for (var/key in reagents_by_phase)
			var/list/data = reagents_by_phase[key]
			if (isnull(data))
				continue
			moles += data[1]

	return moles


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
			if (isnull(data))
				continue
			var/partial_volume = R.fluid_volume(data[1], phase)
			volume += partial_volume

	return volume

/// Calculates the gas pressure of the mixture
/datum/chem/mixture/proc/pressure()
	var/pressure = PA(0)
	var/remaining_volume = clamp(src.container_volume - src.volume(), MILLILITRES(0.1), src.container_volume)

	for (var/phase in src.reagents)
		if (phase != PHASE_GAS)
			continue
		var/list/reagents_by_phase = src.reagents[phase]
		for (var/key in reagents_by_phase)
			var/datum/chem/reagent/R = GLOBALS.atmoschem_controller.reagents[key]
			var/list/data = reagents_by_phase[key]
			if (isnull(data))
				continue
			var/partial_pressure = R.gas_pressure(data[1], data[2], remaining_volume)
			pressure += partial_pressure
	
	return pressure

/// Based upon the reagents in the mixture, return the possible reactions
/datum/chem/mixture/proc/potential_reactions()
	src.reagents = sortList(src.reagents)
	var/key = src.reagents.Join("-")

	VAR_STATIC(list/cached_reactions) = list()

	if (key in cached_reactions)
		return cached_reactions[key]
