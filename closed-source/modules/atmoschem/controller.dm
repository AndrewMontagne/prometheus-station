
VAR_GLOBAL(controller/atmoschem/atmoschem_controller)

/// The Atmos/Chemistry Controller
/controller/atmoschem
	priority = PRIORITY_LOW
	tick_rate = 2
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

	var/list/directions = list(NORTH, SOUTH, EAST, WEST)
	var/list/turf/basic/open/turfs = list()
	for (var/turf/basic/open/T in world.contents)
		turfs.Add(T)

	for (var/V in turfs)
		sleep(-1)
		var/turf/basic/open/T = V
		if (isnull(T))
			continue
		var/moles_to_exchange = GAS_EXCHANGE_CONST * (T.atmos.pressure() / ATM(1)) * 4
		var/total_moles = T.atmos.total_moles()
		if ((moles_to_exchange * 4) > total_moles)
			moles_to_exchange = total_moles / 4

		var/pres = T.atmos.pressure() / 1000
		T.color = rgb(pres, pres, pres)
		
		for (var/dir in directions)
			var/turf/basic/open/dir_turf = get_step(T, dir)
			if (istype(dir_turf))
				var/gas_packet = T.atmos.remove_moles(moles_to_exchange, list(PHASE_GAS))
				dir_turf.inbound_atmos.Add(list(gas_packet))
		
	for (var/V in turfs)
		sleep(-1)
		var/turf/basic/open/T = V
		if (isnull(T))
			continue
		for (var/inbound_packet in T.inbound_atmos)
			T.atmos.add_reagents(inbound_packet)
		T.inbound_atmos = list()

	for (var/datum/chem/mixture/M)
		M.simulate()


/world/init_controllers(datum/scheduler/scheduler)
	. = ..()
	scheduler.add_controller(new /controller/atmoschem())
