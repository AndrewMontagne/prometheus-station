
// Click handler
/mob/proc/HandleClick(object, location, control, params)

	var/list/parameters = params2list(params)
	var/atom/A = object

	if(parameters["shift"] && parameters["ctrl"])
		A.OnCtrlShiftClick(src, parameters)
		return
	if(parameters["shift"])
		A.OnShiftClick(src, parameters)
		return
	if(parameters["alt"])
		A.OnAltClick(src, parameters)
		return
	if(parameters["ctrl"])
		A.OnCtrlClick(src, parameters)
		return

	A.OnClick(src, parameters)

// Double Click handler
/mob/proc/HandleDoubleClick(object, location, control, params)

	var/list/parameters = params2list(params)
	var/atom/A = object

	if(parameters["shift"] && parameters["ctrl"])
		A.OnCtrlShiftClick(src, parameters)
		return
	if(parameters["shift"])
		A.OnShiftClick(src, parameters)
		return
	if(parameters["alt"])
		A.OnAltClick(src, parameters)
		return
	if(parameters["ctrl"])
		A.OnCtrlClick(src, parameters)
		return

	A.OnDoubleClick(src, parameters)

