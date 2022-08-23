// Singletons defining each reagent
/datum/chem/reagent
	var/key = null
	var/latent_heat_of_vapourisation = JOULES(2257)
	var/latent_heat_of_fusion		 = JOULES(333.55)
	var/std_melting_point			 = CELSIUS(0)
	var/std_boiling_point			 = CELSIUS(100)
	var/triple_point_pres			 = ATM(0.06)
	var/decomposition_reaction       = null
	var/decomposition_temperature	 = CELSIUS(5000)
	var/molar_mass					 = GRAMS(18)
	var/density_solid				 = KG_PER_L(0.916)
	var/density_liquid				 = KG_PER_L(1)

/// Calculates the volume of a reagent, as a solid/liquid
/datum/chem/reagent/proc/fluid_volume(var/moles, var/solid)
	return moles * src.molar_mass * src.density_solid

/// Calculates the volume of a reagent, as a gas
/datum/chem/reagent/proc/gas_pressure(var/moles, var/temperature, var/volume)
	return (moles * temperature * IDEAL_GAS_CONSTANT)

/datum/chem/reagent/proc/melting_point(var/pressure)
	return src.std_melting_point

/datum/chem/reagent/proc/boiling_point(var/pressure)
	var/delta_t = src.std_boiling_point - src.std_melting_point
	var/delta_p = ATM(1) - src.triple_point_pres

	return (delta_t / delta_p) * (pressure - src.triple_point_pres) + src.std_melting_point
