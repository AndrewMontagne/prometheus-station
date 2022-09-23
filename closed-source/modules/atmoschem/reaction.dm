/datum/chem/reaction
	var/list/ingredients	= list()
	var/list/products		= list()
	var/minimum_temperature	= CELSIUS(0)
	var/maximum_temperature	= null
	var/thermic_energy		= JOULES(0)
	var/reaction_sound		= null
	var/reaction_desc		= null

/datum/chem/reaction/proc/can_react(var/datum/chem/mixture/M)
	return TRUE

/datum/chem/reaction/proc/on_react(var/obj/container)
	if (src.reaction_sound)
		play_sound(src.reaction_sound, container)
	if (src.reaction_desc)
	
