/obj/item
	VAR_PRIVATE/list/proper_tool_types = null
	VAR_PRIVATE/list/improper_tool_types = null

/obj/item/proc/tool_act(var/tool_type, var/proper_only = FALSE)
	if (tool_type in src.proper_tool_types)
		return TOOL_PROPER
	if (!proper_only && (tool_type in src.improper_tool_types))
		return TOOL_IMPROPER
	return TOOL_NONE

/obj/item/proc/get_tool_types(var/proper_only = FALSE)
	if (proper_only)
		return src.proper_tool_types
	else
		return src.proper_tool_types | src.improper_tool_types

/obj/item/tool
	icon = 'assets/cc-by-sa-nc/icons_new/item/tools.dmi'

/obj/item/tool/wrench
	name = "wrench"
	desc = "An adjustable wrench that fits all bolts with an even number of sides."
	proper_tool_types = list(TOOL_WRENCH)
	icon_state = "wrench"

/obj/item/tool/screwdriver
	name = "screwdriver"
	desc = "A bog-standard screwdriver with a star-shaped head."
	proper_tool_types = list(TOOL_SCREWDRIVER)
	improper_tool_types = list(TOOL_CROWBAR)
	icon_state = "screwdriver"

/obj/item/tool/crowbar
	name = "crowbar"
	desc = "A large piece of metal for applying leverage."
	proper_tool_types = list(TOOL_CROWBAR)
	icon_state = "crowbar"

/obj/item/tool/welding
	name = "welding tool"
	desc = "A specialised blowtorch for joining or splitting pieces of metal."
	proper_tool_types = list(TOOL_WELDING)
	icon_state = "welder1"

/obj/item/tool/cutters
	name = "wire cutters"
	desc = "A pair of special scissors designed for cutting wires."
	proper_tool_types = list(TOOL_CUTTERS)
	icon_state = "cutters"
