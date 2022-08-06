/area
	icon = 'assets/cc-by-sa-nc/icons_new/areas.dmi'
	icon_state = "unknown"
	invisibility = VISIBLITY_NEVER
	layer = 10
	plane = 0
	var/sound_environment = -1

/**
Space Area
**/
/area/space
	name = "Space"
	desc = "It's cold outside, there's no kind of atmosphere."
	icon_state = "space"

/**
Station Area

Base class for all "rooms"
**/
/area/station
	name = "Station"
	sound_environment = 12

/area/station/maint
	sound_environment = 21

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

/area/station/service
	name = "Station Services"
	icon_state = "svc_generic"

/area/station/service/kitchen
	name = "Kitchen"
	icon_state = "svc_kitchen"

/area/station/service/cafeteria
	name = "Cafeteria"
	icon_state = "svc_cafe"

/area/station/engineering
	name = "Engineering"
	icon_state = "eng_generic"

/area/station/engineering/main
	name = "Main Engineering"
	icon_state = "eng_main"

/area/station/engineering/main
	name = "Atmospherics"
	icon_state = "eng_atmos"

/area/station/engineering/solars_airlock
	name = "Solars Airlock"
	icon_state = "eng_solars"
