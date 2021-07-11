/area
	icon = 'assets/cc-by-sa-nc/icons/turf/areas.dmi'
	icon_state = "unknown"
	invisibility = ALWAYS_INVISIBLE
	layer = 10
	plane = 0

/**
Space Area
**/
/area/space
	name = "Space"
	desc = "It's cold outside, there's no kind of atmosphere."
	dynamic_lighting = FALSE
	icon_state = "space"

/**
Station Area

Base class for all "rooms"
**/
/area/station
	name = "Station"
	icon_state = "crew_quarters"
