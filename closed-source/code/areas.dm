/area
	icon = 'assets/cc-by-sa-nc/icons_new/areas.dmi'
	icon_state = "unknown"
	invisibility = VISIBLITY_NEVER
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

/area/station/maint/deck1
	name = "Deck 1 Maintenance Hall"
	icon_state = "deck1_maint"

/area/station/maint/deck2
	name = "Deck 2 Maintenance Hall"
	icon_state = "deck2_maint"

/area/station/maint/deck3
	name = "Deck 3 Maintenance Hall"
	icon_state = "deck3_maint"

/area/station/main_hallway/aft
	name = "Aft Main Hallway"
	icon_state = "aft_main_hall"

/area/station/main_hallway/fore
	name = "Fore Main Hallway"
	icon_state = "fore_main_hall"

/area/station/main_hallway/starboard
	name = "Starboard Main Hallway"
	icon_state = "starb_main_hall"

/area/station/main_hallway/port
	name = "Port Main Hallway"
	icon_state = "port_main_hall"

/area/station/main_hallway/center
	name = "Central Main Hallway"
	icon_state = "center_main_hall"
