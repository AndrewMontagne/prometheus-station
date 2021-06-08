/mob/
	sight = SEE_BLACKNESS | SEE_SELF
	animate_movement = 2
	glide_size = 16
	mouse_over_pointer = MOUSE_HAND_POINTER

/// Fired when the mob loses its client
/mob/proc/on_lose_client()

/// Fired when the mob gains a client
/mob/proc/on_gain_client()

// Handler for the input change button
/mob/verb/change_input()
	set name = "ChangeInput"
	set hidden = 1

	var/verbname = input("Input Verb", "Select your input verb:", "Say") in list("Say", "Whisper", "OOC", "AHelp")
	var/lowerverb = lowertext(verbname)
	winset(usr, null, "outputwindow.input.command=\"![lowerverb] \\\"\"; outputwindow.inputbutton.text=\"[verbname]\"")
