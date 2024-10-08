/obj/screen/splash
	icon = 'assets/cc-by-sa-nc/icons/misc/splash.dmi'
	icon_state = "ss13"
	screen_loc = "CENTER:-104,CENTER:-16"
	mouse_over_pointer = MOUSE_INACTIVE_POINTER
	name = "Splash Screen"

/mob/lobby
	var/ready = 0
	invisibility = VISIBLITY_NEVER
	density = FALSE
	sight = BLIND

	ready = FALSE

	VAR_STATIC(obj/screen/splash/splashscreen)
	VAR_STATIC(lobby_music_track) = pick('closed-source/music/robocop.ogg','closed-source/music/tintin.ogg')

/mob/lobby/New()
	. = ..()
	src.init_chat()

/mob/lobby/Login()
	..()

	x = 50
	y = 50
	z = 2

	if(isnull(splashscreen))
		src.splashscreen = new /obj/screen/splash()
		src.ui = list(src.splashscreen)

	src.rebuild_screen()

	src << sound(lobby_music_track, repeat = 0, wait = 0, channel=1337)

	src << browse("<html><body>[GLOBALS.motd]</body></html>", "window=loginwindow")
	update_login_window()
	winset(src, "loginwindow", "is-visible=true;")
	src.set_chat_verb("OOC")

/mob/lobby/Logout()
	ready = 0
	..()
	del(src)

/// Updates the login window
/mob/lobby/proc/update_login_window()
	if (isnull(GLOBALS.game_loop))
		winset(src, "loginwindow.loginbutton_ready", "border=line; text=\"Ready Up\"; background-color=#00dc00; focus=false")
		winset(src, "login_label", "text=\"Starting up...\"")
		return
		
	if (GLOBALS.game_loop.is_pre_game())
		if (!ready)
			winset(src, "loginwindow.loginbutton_ready", "border=line; text=\"Ready Up\"; background-color=#00dc00; focus=false")
		else
			winset(src, "loginwindow.loginbutton_ready", "border=sunken; text=\"Cancel\"; background-color=#dc0000; focus=false")

		var/secs = GLOBALS.game_loop.state.seconds_left()
		var/label = "Round start has been delayed"
		if (!isnull(secs))
			secs -= 2
			var/mins = (secs - (secs % 60)) / 60
			secs %= 60
			var/time = "in"
			if (mins > 0)
				time += " [mins] min"
			time += " [secs] secs"
			if (GLOBALS.game_loop.state.seconds_left() <= 1)
				time = "shortly..."
			label = "Round starts [time]"
		winset(src, "login_label", "text=\"[label]\"")
	else
		winset(src, "loginwindow.loginbutton_ready", "border=line; text=\"Join Round\"; background-color=#00bbdc; focus=false")
		winset(src, "login_label", "text=\"Welcome to [world.name]!\"")

/// Verb used by players in the lobby to toggle their "ready" status
/mob/lobby/verb/toggle_ready()
	set name = "toggleready"

	if(GLOBALS.game_loop.is_pre_game())
		if (!usr.client.has_permission("BAN"))
			src << "You are not authorized to enter the game."
			return

		ready = !ready
	
	src.update_login_window()

/mob/lobby/Move()
	return FALSE

/mob/lobby/on_lose_client()
	. = ..()
	winset(src, "loginwindow", "is-visible=false;")
	src << sound(null, repeat = 0, wait = 0, channel = 1337)
