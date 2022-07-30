
/mob/proc/get_held_object()
	return null

// Click handler
/mob/proc/HandleClick(object, location, control, parameters)
	var/atom/A = object
	
	var/dy = ((A.y - src.y) * 32) + (text2num(parameters["icon-y"]) - 16)
	var/dx = ((A.x - src.x) * 32) + (text2num(parameters["icon-x"]) - 16)
	var/angle = arctan(dx, dy)

	parameters["angle"] = angle
	src.dir = angle_to_dir(angle)

	var/atom/held_object = src.get_held_object()
	if (isnull(held_object))
		held_object = src

	if(parameters["shift"] && parameters["ctrl"])
		A.ThrowClick(src, held_object, parameters)
		return
	if(parameters["shift"])
		A.HarmClick(src, held_object, parameters)
		return
	if(parameters["alt"])
		A.DisarmClick(src, held_object, parameters)
		return
	if(parameters["ctrl"])
		A.GrabClick(src, held_object, parameters)
		return

	A.HelpClick(src, held_object, parameters)

// Double Click handler
/mob/proc/HandleDoubleClick(object, location, control, parameters)
	var/atom/A = object

	var/atom/held_object = src.get_held_object()
	if (isnull(held_object))
		held_object = src

	if(parameters["shift"] && parameters["ctrl"])
		A.ThrowDoubleClick(src, held_object, parameters)
		return
	if(parameters["shift"])
		A.HarmDoubleClick(src, held_object, parameters)
		return
	if(parameters["alt"])
		A.DisarmDoubleClick(src, held_object, parameters)
		return
	if(parameters["ctrl"])
		A.GrabDoubleClick(src, held_object, parameters)
		return

	A.HelpDoubleClick(src, held_object, parameters)
