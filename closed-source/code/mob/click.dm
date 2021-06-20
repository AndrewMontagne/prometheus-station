
// Click handler
/mob/proc/HandleClick(object, location, control, parameters)
	var/atom/A = object

	if(parameters["shift"] && parameters["ctrl"])
		A.ThrowClick(src, parameters)
		return
	if(parameters["shift"])
		A.HarmClick(src, parameters)
		return
	if(parameters["alt"])
		A.DisarmClick(src, parameters)
		return
	if(parameters["ctrl"])
		A.GrabClick(src, parameters)
		return

	A.HelpClick(src, parameters)

// Double Click handler
/mob/proc/HandleDoubleClick(object, location, control, parameters)
	var/atom/A = object

	if(parameters["shift"] && parameters["ctrl"])
		A.ThrowDoubleClick(src, parameters)
		return
	if(parameters["shift"])
		A.HarmDoubleClick(src, parameters)
		return
	if(parameters["alt"])
		A.DisarmDoubleClick(src, parameters)
		return
	if(parameters["ctrl"])
		A.GrabDoubleClick(src, parameters)
		return

	A.HelpDoubleClick(src, parameters)
