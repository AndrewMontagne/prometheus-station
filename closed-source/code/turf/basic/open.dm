/turf/basic/open
	icon = 'assets/cc-by-sa-nc/icons/turf/floors.dmi'
	var/datum/chem/mixture/atmos

/turf/basic/open/New()
	. = ..()
	src.atmos = new /datum/chem/mixture(CUBIC_TILES(1), DEFAULT_GAS_MIX)
	src.atmos.name = "atmosphere ([src.name])"

/turf/basic/open/floor
	name = "floor"
	icon_state = "floor"

/turf/basic/open/floor/ToolAct(mob/holder, obj/item/tool/tool, list/parameters)
	if (tool.is_valid_tool(TOOL_CROWBAR, TRUE))
		for (var/obj/structure/network_node/N in src.contents)
			N.invisibility = VISIBLITY_ALWAYS
		var/obj/item/stack/floor_tile/F = new(src)
		F.pixel_x = rand(-8,8)
		F.pixel_y = rand(-8,8)
		F.count = 1
		src.change_turf(/turf/basic/open/plating)
		tool.play_tool_sound()

/turf/basic/open/plating
	name = "floor"
	icon = 'assets/cc-by-sa-nc/icons_new/turf/floors/smooth/plating.dmi'
	icon_state = "placeholder"
	smoothing_type = SMOOTHING_TURFS
	