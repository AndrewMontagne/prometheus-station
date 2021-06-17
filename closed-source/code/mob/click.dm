
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

/mob
	var/modifier_shift = FALSE
	var/modifier_ctrl = FALSE
	var/modifier_alt = FALSE

/mob/proc/update_cursor()
	if (src.modifier_shift && src.modifier_ctrl)
		src.client.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/throw.dmi'
	else if (src.modifier_shift)
		src.client.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/harm.dmi'
	else if (src.modifier_ctrl)
		src.client.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/grab.dmi'
	else if (src.modifier_alt)
		src.client.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/disarm.dmi'
	else
		src.client.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/help.dmi'


// Modifier Handlers
/mob/verb/shiftdown()
	set hidden = TRUE
	src.modifier_shift = TRUE
	src.update_cursor()

/mob/verb/shiftup()
	set hidden = TRUE
	src.modifier_shift = FALSE
	src.update_cursor()

/mob/verb/ctrldown()
	set hidden = TRUE
	src.modifier_ctrl = TRUE
	src.update_cursor()

/mob/verb/ctrlup()
	set hidden = TRUE
	src.modifier_ctrl = FALSE
	src.update_cursor()

/mob/verb/altdown()
	set hidden = TRUE
	src.modifier_alt = TRUE
	src.update_cursor()

/mob/verb/altup()
	set hidden = TRUE
	src.modifier_alt = FALSE
	src.update_cursor()
