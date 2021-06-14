
// Click handler
/mob/proc/HandleClick(object, location, control, parameters)
	var/atom/A = object

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

// Modifier Handlers
/mob/verb/shiftdown()
	set hidden = TRUE
	src.client.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/harm.dmi'
/mob/verb/shiftup()
	set hidden = TRUE
	src.client.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/help.dmi'

/mob/verb/ctrldown()
	set hidden = TRUE
	src.client.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/grab.dmi'
/mob/verb/ctrlup()
	set hidden = TRUE
	src.client.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/help.dmi'

/mob/verb/altdown()
	set hidden = TRUE
	src.client.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/disarm.dmi'
/mob/verb/altup()
	set hidden = TRUE
	src.client.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/help.dmi'
