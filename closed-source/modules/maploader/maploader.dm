
/datum/map_loader
	var/should_sleep = TRUE
	var/list/map_data = null
	var/list/atom/atoms_to_init = list()
	var/list/tile_defs = null
	var/key_width = 0

/datum/map_loader/New(var/_should_sleep=TRUE)
	src.should_sleep = _should_sleep

/datum/map_loader/proc/load_map(var/map_file)
	
	if (!fexists(map_file))
		CRASH("Map does not exist!")

	var/STATE_TILE_DEFS = 1
	var/STATE_Z_LEVEL = 2
	var/state = STATE_TILE_DEFS

	var/regex/tile_def_regex = regex(@'^"(\w{1,3})" = \(([^)]+)\)$')
	src.key_width = 0
	src.tile_defs = list()

	var/regex/z_level_start_regex = regex(@'^\((\d+),(\d+),(\d+)\) = \{"$')
	var/origin_x = 0
	var/origin_y = 0
	var/origin_z = 0
	var/current_y = 0
	var/current_z = 0
	var/list/z_level_data = list()
	src.map_data = list()

	var/list/lines = splittext_char(file2text(map_file), "\n")

	for (var/line in lines)
		if (should_sleep)
			sleep(-1)

		if (state == STATE_TILE_DEFS)
			if (tile_def_regex.Find(line) != 0)
				var/key = tile_def_regex.group[1]

				if (src.key_width == 0)
					src.key_width = length_char(key)
				else if(length_char(key) != src.key_width)
					CRASH("Key size mismatch!")

				src.tile_defs[key] = tile_def_regex.group[2]

			else if (z_level_start_regex.Find(line) != 0)
				origin_x = text2num(z_level_start_regex.group[1])
				origin_y = text2num(z_level_start_regex.group[2])
				origin_z = text2num(z_level_start_regex.group[3])
				state = STATE_Z_LEVEL
				z_level_data = list()
				current_y = 1
				current_z++

		else if (state == STATE_Z_LEVEL)
			if (line == "\"}")
				state = STATE_TILE_DEFS
				src.map_data[num2text(origin_z)] = z_level_data
				continue

			if (length_char(line) % key_width != 0)
				CRASH("Inconsistent level data")

			var/expected_symbols = length_char(line) / key_width

			var/list/current_z_data = list()

			for (var/i=1, i<=expected_symbols, i++)
				var/start = ((i-1) * key_width) + 1
				var/end = (i * key_width) + 1
				var/key = copytext_char(line, start, end)
				current_z_data.Add(key)

			z_level_data[num2text(current_y)] = current_z_data
			current_y += 1


/datum/map_loader/proc/write_map(start_x, start_y, start_z, should_sleep)
	var/total_width = length(src.map_data["1"]["1"])
	var/total_height = length(src.map_data["1"])
	var/total_depth = length(src.map_data)

	start_x--
	start_y--
	start_z--

	var/target_max_x = total_width + start_x
	var/target_max_y = total_height + start_y
	var/target_max_z = total_depth + start_z

	if (world.maxx < target_max_x)
		world.maxx = target_max_x
	if (world.maxy < target_max_y)
		world.maxy = target_max_y
	if (world.maxz < target_max_z)
		world.maxz = target_max_z

	var/regex/data_extract_regex = regex(@'^([a-zA-Z/0-9_]+)\{([^}]+)\}')
	var/regex/param_extract_regex = regex(@'^([a-zA-Z/0-9_]+) = (.+)$')
	
	for (var/z_level_num in src.map_data)
		var/current_z = text2num(z_level_num)
		var/list/z_level_data = src.map_data[z_level_num]
		for (var/y_key in z_level_data)
			var/list/row = z_level_data[y_key]
			var/current_y = (total_height + 1) - text2num(y_key)
			var/current_x = 1
			for (var/col in row)
				if (should_sleep)
					sleep(-1)
				var/list/definitions = splittext_char(src.tile_defs[col], ",")
				for (var/object in definitions)
					var/list/data = null
					if (data_extract_regex.Find(object))
						data = splittext(data_extract_regex.group[2], ";")
						object = data_extract_regex.group[1]
					else
						data = list()

					var/path = text2path(object)

					if (path == world.turf || path == world.area)
						continue

					var/loc = locate(current_x + start_x, current_y + start_y, current_z + start_z)

					var/list/params = list()
					for (var/datum in data)
						if (param_extract_regex.Find(datum) == 0)
							LOG_WARNING("Unable to process map datum: '" + datum + "'")
						else
							var/variable = param_extract_regex.group[1]
							var/var_value = param_extract_regex.group[2]

							if (copytext_char(var_value, 1,2) == "\"")
								var_value = copytext_char(var_value, 2,-1)
							else
								var_value = text2num(var_value)

							params[variable] = var_value

					var/atom/A = new path(loc, params)

					try
						if (A.needs_init)
							src.atoms_to_init.Add(A)
					catch
						//NOOP

				current_x++
			current_y--

/datum/map_loader/proc/init_atoms()
	for (var/i in src.atoms_to_init)
		var/atom/A = i
		LOG_TRACE(text("Init []", A))
		A.Initialise()
		sleep(-1)
	src.atoms_to_init = list()
