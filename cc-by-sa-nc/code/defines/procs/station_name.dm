/proc/station_name()
	if (station_name)
		return station_name

	station_name = "NMS Prometheus"

	world.name = station_name

	return station_name
