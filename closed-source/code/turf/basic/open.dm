/turf/basic/open
	icon = 'assets/cc-by-sa-nc/icons/turf/floors.dmi'

/turf/basic/open/floor
	name = "floor"
	icon_state = "floor"

/turf/basic/open/floor/HelpClick(mob/holder, atom/item, list/params)
	. = ..()
	if (!src.Adjacent(holder))
		return

	if (istype(item, /obj/item/tool))
		var/obj/item/tool/T = item
		if (TOOL_CROWBAR in T.proper_tool_types)
			for (var/obj/network_node/N in src.contents)
				N.invisibility = VISIBLITY_ALWAYS
			var/obj/item/stack/floor_tile/F = new(src)
			F.pixel_x = rand(-8,8)
			F.pixel_y = rand(-8,8)
			F.count = 1
			src.change_turf(/turf/basic/open/plating)

/turf/basic/open/plating
	name = "floor"
	icon = 'assets/cc-by-sa-nc/icons_new/turf/floors/smooth/plating.dmi'
	icon_state = "placeholder"
	smoothing_type = SMOOTHING_SIMPLE

/turf/basic/open/plating/HelpClick(mob/holder, atom/item, list/params)
	. = ..()
	if (!src.Adjacent(holder))
		return

	if (istype(item, /obj/item/stack/floor_tile))
		var/obj/item/stack/floor_tile/T = item
		if (T.remove(1))
			for (var/obj/network_node/N in src.contents)
				N.invisibility = VISIBLITY_UNDER_TILE
			src.change_turf(/turf/basic/open/floor)
