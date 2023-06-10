/// Singletons defining each reagent
/datum/chem/reagent
	var/key = null
	/// The amount of heat to transition between liquid/gas in J/mol
	var/latent_heat_of_vapour 		= JOULES(2257)
	/// The amount of heat to transition between solid/liquid in J/mol
	var/latent_heat_of_fusion		= JOULES(333.55)
	/// The melting point of this reagent at 1 atmosphere
	var/std_melting_point			= CELSIUS(0)
	/// The boiling point of this reagent at 1 atmosphere
	var/std_boiling_point			= CELSIUS(100)
	/// The pressure that this reagent is at its triple point
	var/triple_point_pres			= ATM(0.06)
	/// The reaction that occurs when this reagent reaches its decomposition temperature
	var/decomposition_reaction      = null
	/// The temperature the decomposition reaction occurs, in K
	var/decomposition_temperature	= null
	/// The mass of one mole of this reagent
	var/molar_mass					= GRAMS(18)
	/// The density of the reagent as a solid in kg/L
	var/density_solid				= KGS_PER_LITRE(0.916)
	/// The density of the reagent as a liquid in kg/L
	var/density_liquid				= KGS_PER_LITRE(1)
	/// The specific heat of the reagent as a solid/gas in J/mol*K
	var/specific_heat				= 73.32


/// Calculates the volume of a reagent, as a solid/liquid
/datum/chem/reagent/proc/fluid_volume(var/moles, var/phase, var/container_volume)
	if (phase == PHASE_SOLID)
		return moles * src.molar_mass * src.density_solid
	else if (phase == PHASE_LIQUID)
		return moles * src.molar_mass * src.density_liquid
	else
		return container_volume // Gases always fill their container


/// Calculates the volume of a reagent, as a gas
/datum/chem/reagent/proc/gas_pressure(var/moles, var/temperature, var/container_volume)
	return (moles * temperature * IDEAL_GAS_CONSTANT) / (container_volume / CUBIC_METRES(1))


/**
  * Returns the boiling point of a reagent.
  *
  * On the phase diagram for reagents, the boiling point is a line passing through 
  * the [melting point of the reagent at STP][/datum/chem/reagent/var/std_melting_point] 
  * at [the triple point pressure of the reagent][/datum/chem/reagent/var/triple_point_pres]
  * and passing through [boiling point of the reagent at STP][/datum/chem/reagent/var/std_boiling_point]
  */
/datum/chem/reagent/proc/boiling_point(var/pressure)
	var/delta_t = src.std_boiling_point - src.std_melting_point
	var/delta_p = ATM(1) - src.triple_point_pres

	return (delta_t / delta_p) * (pressure - src.triple_point_pres) + src.std_melting_point


/**
  * Returns the melting point of a reagent.
  *
  * On the phase diagram for reagents, the melting point is vertical line starting
  * at the [melting point of the reagent at STP][/datum/chem/reagent/var/std_melting_point] 
  * at [the triple point pressure of the reagent][/datum/chem/reagent/var/triple_point_pres]
  * and going up to infinity. Below the triple point of the reagent it cannot 
  * exist as a liquid and instead sublimates.
  */
/datum/chem/reagent/proc/melting_point(var/pressure)
	return src.std_melting_point


/**
  * Calculates the specific heat of a reagent according to its phase
  *
  * For simplicity, we assume by default that all reagents have a single value
  * for specific heat, that is doubled when it is a liquid. I based this off of
  * looking at the specific heat of various reagents in all phases and noticed a
  * pattern.
  *
  * This can be overriden per reagent if it really matters.
  */
/datum/chem/reagent/proc/phase_specific_heat(var/phase)
	// This isn't accurate, but the liquid phase of reagents tends to be about
	// double that of the gas phase
	if (phase == PHASE_LIQUID)
		return src.specific_heat * 2
	
	// The gas and solid phases of matter tend to be the same
	return src.specific_heat


/// Calculates the temperature in K of a reagent given energy, moles and the phase
/datum/chem/reagent/proc/temperature(var/thermal_energy, var/moles, var/phase)
	return thermal_energy / (src.phase_specific_heat(phase) * moles)

/// Calculates the thermal energy in J of a reagent given temperature, moles and the phase
/datum/chem/reagent/proc/thermal_energy(var/temperature, var/moles, var/phase)
	return src.phase_specific_heat(phase) * moles * temperature


/// Calculates the mass in kg of a reagent given moles
/datum/chem/reagent/proc/mass(var/moles)
	return src.molar_mass * moles


/// Calculates amount of moles given mass
/datum/chem/reagent/proc/moles(var/mass)
	return mass / src.molar_mass
