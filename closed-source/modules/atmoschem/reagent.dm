// Singletons defining each reagent
/datum/chem/reagent
	var/key = null
	var/latent_heat_of_vapour 		= JOULES(2257)
	var/latent_heat_of_fusion		= JOULES(333.55)
	var/std_melting_point			= CELSIUS(0)
	var/std_boiling_point			= CELSIUS(100)
	var/triple_point_pres			= ATM(0.06)
	var/decomposition_reaction      = null
	var/decomposition_temperature	= null
	var/molar_mass					= GRAMS(18)
	var/density_solid				= KGS_PER_LITRE(0.916)
	var/density_liquid				= KGS_PER_LITRE(1)

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

/datum/chem/reagent/proc/melting_point(var/pressure)
	return src.std_melting_point

/datum/chem/reagent/proc/boiling_point(var/pressure)
	var/delta_t = src.std_boiling_point - src.std_melting_point
	var/delta_p = ATM(1) - src.triple_point_pres

	return (delta_t / delta_p) * (pressure - src.triple_point_pres) + src.std_melting_point
