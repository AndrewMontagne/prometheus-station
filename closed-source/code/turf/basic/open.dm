/turf/basic/open
	icon = 'assets/cc-by-sa-nc/icons/turf/floors.dmi'

/turf/basic/open/floor
	name = "floor"
	icon_state = "floor"

/turf/basic/open/floor/HelpClick(mob/holder, atom/item, list/params)
	. = ..()
	if (istype(item, /obj/item/tool))
		var/obj/item/tool/T = item
		if (TOOL_CROWBAR in T.proper_tool_types)
			src.change_turf(/turf/basic/open/plating)

/turf/basic/open/plating
	name = "floor"
	icon = 'assets/cc-by-sa-nc/icons_new/turf/floors/smooth/plating.dmi'
	icon_state = "placeholder"
	smoothing_type = SMOOTHING_SIMPLE
