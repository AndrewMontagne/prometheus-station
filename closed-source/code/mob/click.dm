
// Click handler
/mob/proc/HandleClick(object, location, control, params)

	var/list/parameters = params2list(params)
	var/atom/A = object

	if(parameters["shift"] && parameters["middle"])
		A.OnShiftMiddleClick(object, parameters)
		return
	if(parameters["ctrl"] && parameters["middle"])
		A.OnCtrlMiddleClick(object, parameters)
		return
	if(parameters["shift"] && parameters["shift"] && parameters["middle"])
		A.OnCtrlShiftMiddleClick(object, parameters)
		return
	if(parameters["middle"])
		A.OnMiddleClick(object, parameters)
		return

	if(parameters["shift"] && parameters["ctrl"])
		A.OnCtrlShiftClick(object, parameters)
		return
	if(parameters["shift"])
		A.OnShiftClick(object, parameters)
		return
	if(parameters["alt"])
		A.OnAltClick(object, parameters)
		return
	if(parameters["ctrl"])
		A.OnCtrlClick(object, parameters)
		return

// Double Click handler
/mob/proc/HandleDoubleClick(object, location, control, params)

	var/list/parameters = params2list(params)
	var/atom/A = object

	if(parameters["shift"] && parameters["ctrl"])
		A.OnCtrlShiftClick(object, parameters)
		return
	if(parameters["shift"])
		A.OnShiftClick(object, parameters)
		return
	if(parameters["alt"])
		A.OnAltClick(object, parameters)
		return
	if(parameters["ctrl"])
		A.OnCtrlClick(object, parameters)
		return

