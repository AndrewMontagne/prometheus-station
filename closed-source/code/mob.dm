/mob/
	sight = SEE_BLACKNESS | SEE_SELF
	animate_movement = 2
	glide_size = 16
	mouse_over_pointer = MOUSE_HAND_POINTER
	var/list/ui = list()
	var/list/chat_verbs = list("OOC", "Ahelp")
	var/default_chat_verb = "OOC"
	var/current_chat_verb = null

/// Fired when the mob loses its client
/mob/proc/on_lose_client()
	client.screen -= src.ui

/// Fired when the mob gains a client
/mob/proc/on_gain_client()
	src.rebuild_screen()
	if (isnull(src.current_chat_verb))
		src.current_chat_verb = src.default_chat_verb
		src.set_chat_verb(src.default_chat_verb)

/mob/proc/rebuild_screen()
	if (src.client)
		src.client.rebuild_screen()

/mob/proc/set_chat_verb(verbname)
	src.current_chat_verb = verbname
	if (src.client)
		var/lowerverb = lowertext(verbname)
		winset(src.client, null, "outputwindow.input.command=\"![lowerverb] \\\"\"; outputwindow.inputbutton.text=\"[verbname]\"")

// Handler for the input change button
/mob/verb/change_input()
	set name = "ChangeInput"
	set hidden = 1

	var/verbname = input("Input Verb", "Select your input verb:", src.current_chat_verb) in src.chat_verbs
	src.set_chat_verb(verbname)
