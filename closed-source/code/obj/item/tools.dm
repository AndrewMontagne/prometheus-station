/obj/item/tool
	icon = 'assets/cc-by-sa-nc/icons_new/item/tools.dmi'
	VAR_PRIVATE/list/proper_tool_types = null
	VAR_PRIVATE/list/improper_tool_types = null
	var/tool_use_sound = 'assets/cc-by-sa-nc/sound/items/Deconstruct.ogg'
	slots = list(SLOT_POCKET, SLOT_BELT_CLIP_L, SLOT_BELT_CLIP_R)

/obj/item/tool/proc/is_valid_tool(var/tool_type, var/proper_only = FALSE)
	if (tool_type in src.proper_tool_types)
		return TOOL_PROPER
	if (!proper_only && (tool_type in src.improper_tool_types))
		return TOOL_IMPROPER
	return TOOL_NONE

/obj/item/tool/proc/get_tool_types(var/proper_only = FALSE)
	if (proper_only)
		return src.proper_tool_types
	else
		return src.proper_tool_types | src.improper_tool_types

/atom/proc/ToolAct(var/mob/holder, var/obj/item/tool/tool, var/list/parameters)
	return FALSE

/obj/item/tool/UseOn(mob/holder, atom/target, list/params)
	return target.ToolAct(holder, src, params)

/obj/item/tool/proc/play_tool_sound()
	play_sound(src.tool_use_sound, src.find_turf())

/obj/item/tool/wrench
	name = "wrench"
	desc = "An adjustable wrench that fits all bolts with an even number of sides."
	proper_tool_types = list(TOOL_WRENCH)
	icon_state = "wrench"
	tool_use_sound = 'assets/cc-by-sa-nc/sound/items/Ratchet.ogg'

/obj/item/tool/screwdriver
	name = "screwdriver"
	desc = "A bog-standard screwdriver with a star-shaped head."
	proper_tool_types = list(TOOL_SCREWDRIVER)
	improper_tool_types = list(TOOL_CROWBAR)
	icon_state = "screwdriver"
	tool_use_sound = 'assets/cc-by-sa-nc/sound/items/Screwdriver.ogg'

/obj/item/tool/crowbar
	name = "crowbar"
	desc = "A large piece of metal for applying leverage."
	proper_tool_types = list(TOOL_CROWBAR)
	icon_state = "crowbar"
	tool_use_sound = 'assets/cc-by-sa-nc/sound/items/Crowbar.ogg'

/obj/item/tool/welding
	name = "welding tool"
	desc = "A specialised blowtorch for joining or splitting pieces of metal."
	proper_tool_types = list(TOOL_WELDING)
	icon_state = "welder1"
	tool_use_sound = 'assets/cc-by-sa-nc/sound/items/Welder.ogg'

/obj/item/tool/cutters
	name = "wire cutters"
	desc = "A pair of special scissors designed for cutting wires."
	proper_tool_types = list(TOOL_CUTTERS)
	icon_state = "cutters"
	tool_use_sound = 'assets/cc-by-sa-nc/sound/items/Wirecutter.ogg'
