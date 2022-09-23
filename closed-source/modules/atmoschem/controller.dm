
VAR_GLOBAL(controller/atmoschem/atmoschem_controller)

/// Networks Controller
/controller/atmoschem
	priority = PRIORITY_LOW
	tick_rate = 1
	name = "Atmospherics / Chemistry"

	var/list/reagents = list()

/controller/atmoschem/New()
	. = ..()
	GLOBALS.atmoschem_controller = src

	var/list/reagent_paths = typesof(/datum/chem/reagent)
	for (var/P in reagent_paths)
		var/datum/chem/reagent/R = new P()
		if (R.key != null)
			src.reagents[R.key] = R

/controller/atmoschem/process()
	. = ..()


/world/init_controllers(datum/scheduler/scheduler)
	. = ..()
	scheduler.add_controller(new /controller/atmoschem())
