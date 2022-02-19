
/obj/machine/door
	icon = 'assets/cc-by-sa-nc/icons/obj/doors/Doormaint.dmi'
	icon_state = "door_closed"
	opacity = FALSE
	density = TRUE
	var/is_opaque = TRUE
	var/is_open = FALSE
	var/in_motion = FALSE
	var/timer = 0
	var/MAX_TIMER = 10

/obj/machine/door/glass
	icon = 'assets/cc-by-sa-nc/icons/obj/doors/Doorglass.dmi'
	is_opaque = FALSE

/obj/machine/door/Initialise()
	. = ..()
	if (src.is_opaque)
		src.set_opacity(TRUE)

/obj/machine/door/process()
	if (src.timer > 0)
		src.timer--
		if (src.timer == 0)
			if (src.is_blocked())
				src.timer = 1
				flick("door_blocked", src)
			else
				src.close()

/obj/machine/door/Bumped(var/atom/movable/source)
	if (!src.in_motion && !src.is_open)
		src.timer = src.MAX_TIMER
		src.open()

/obj/machine/door/proc/toggle()
	if (src.is_open)
		src.close()
	else
		src.open()

/obj/machine/door/proc/open()
	if (!src.is_open && !src.in_motion)
		play_sound('assets/cc-by-sa-nc/sound/machines/airlock.ogg', src)
		flick("door_opening", src)
		src.in_motion = TRUE
		spawn(6)
			icon_state = "door_open"
			if (src.is_opaque)
				src.set_opacity(FALSE)
			src.density = FALSE
		spawn(12)
			src.in_motion = FALSE
			src.is_open = TRUE

/obj/machine/door/proc/close()
	if (src.is_open && !src.in_motion)
		play_sound('assets/cc-by-sa-nc/sound/machines/airlock.ogg', src)
		flick("door_closing", src)
		src.in_motion = TRUE
		src.density = TRUE
		spawn(6)
			icon_state = "door_closed"
		spawn(12)
			src.in_motion = FALSE
			src.is_open = FALSE
			if (src.is_opaque)
				src.set_opacity(TRUE)

/obj/machine/door/proc/is_blocked()
	for (var/atom/movable/A in src.loc)
		if (A.density)
			return TRUE
	return FALSE
