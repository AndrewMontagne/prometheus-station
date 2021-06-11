/mob/
	sight = SEE_BLACKNESS | SEE_SELF
	animate_movement = 2
	glide_size = 16
	mouse_over_pointer = MOUSE_HAND_POINTER
	var/list/screen = list()

/// Fired when the mob loses its client
/mob/proc/on_lose_client()
	client.screen -= src.screen

/// Fired when the mob gains a client
/mob/proc/on_gain_client()
	client.screen += src.screen

// Handler for the input change button
/mob/verb/change_input()
	set name = "ChangeInput"
	set hidden = 1

	var/verbname = input("Input Verb", "Select your input verb:", "Say") in list("Say", "Whisper", "OOC", "AHelp")
	var/lowerverb = lowertext(verbname)
	winset(usr, null, "outputwindow.input.command=\"![lowerverb] \\\"\"; outputwindow.inputbutton.text=\"[verbname]\"")
