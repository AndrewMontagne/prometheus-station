/client
	var/modifier_shift = FALSE
	var/modifier_ctrl = FALSE
	var/modifier_alt = FALSE
	mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/help.dmi'

/client/proc/update_cursor()
	if (src.modifier_shift && src.modifier_ctrl)
		src.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/throw.dmi'
	else if (src.modifier_shift)
		src.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/harm.dmi'
	else if (src.modifier_ctrl)
		src.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/grab.dmi'
	else if (src.modifier_alt)
		src.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/disarm.dmi'
	else
		src.mouse_pointer_icon = 'cc-by-sa-nc/icons_new/cursors/help.dmi'


// Modifier Handlers
/client/verb/shiftdown()
	set hidden = TRUE
	src.modifier_shift = TRUE
	src.update_cursor()

/client/verb/shiftup()
	set hidden = TRUE
	src.modifier_shift = FALSE
	src.update_cursor()

/client/verb/ctrldown()
	set hidden = TRUE
	src.modifier_ctrl = TRUE
	src.update_cursor()

/client/verb/ctrlup()
	set hidden = TRUE
	src.modifier_ctrl = FALSE
	src.update_cursor()

/client/verb/altdown()
	set hidden = TRUE
	src.modifier_alt = TRUE
	src.update_cursor()

/client/verb/altup()
	set hidden = TRUE
	src.modifier_alt = FALSE
	src.update_cursor()
