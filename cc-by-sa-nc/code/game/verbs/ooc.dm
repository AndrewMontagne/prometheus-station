/mob/verb/change_input()
	set name = "ChangeInput"
	set hidden = 1

	var/verbname = input("Input Verb", "Select your input verb:", "Say") in list("Say", "Whisper", "OOC", "AHelp")
	var/lowerverb = lowertext(verbname)
	winset(usr, null, "outputwindow.input.command=\"![lowerverb] \\\"\"; outputwindow.inputbutton.text=\"[verbname]\"")

/mob/verb/listen_ooc()
	set name = "(Un)Mute OOC"

	if (src.client)
		src.client.listen_ooc = !src.client.listen_ooc
		if (src.client.listen_ooc)
			src << "\blue You are now listening to messages on the OOC channel."
		else
			src << "\blue You are no longer listening to messages on the OOC channel."

/mob/verb/ooc(msg as text)
	if (!src.client.authenticated || IsGuestKey(src.key))
		src << "You are not authorized to communicate over these channels."
		return
	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return
	else if (!src.client.listen_ooc)
		return
	else if (!ooc_allowed && !src.client.holder)
		return
	else if (src.muted)
		return
	else if (findtext(msg, "byond://") && !src.client.holder)
		src << "<B>Advertising other servers is not allowed.</B>"
		log_admin("[key_name(src)] has attempted to advertise in OOC.")
		message_admins("[key_name_admin(src)] has attempted to advertise in OOC.")
		return

	log_ooc("[src.name]/[src.key] : [msg]")

	for (var/client/C)
		if (src.client.holder && (!src.client.stealth || C.holder))
//			C << "<span class=\"adminooc\"><span class=\"prefix\">OOC:</span> <span class=\"name\">[src.key]:</span> <span class=\"message\">[msg]</span></span>"
			if (src.client.holder.rank == "Goat Fart")
				C << "<span class=\"gfartooc\"><span class=\"prefix\">OOC:</span> <span class=\"name\">[src.key][src.client.stealth ? "/([src.client.fakekey])" : ""]:</span> <span class=\"message\">[msg]</span></span>"
			else
				C << "<span class=\"adminooc\"><span class=\"prefix\">OOC:</span> <span class=\"name\">[src.key][src.client.stealth ? "/([src.client.fakekey])" : ""]:</span> <span class=\"message\">[msg]</span></span>"

		else if (C.listen_ooc)
			C << "<span class=\"ooc\"><span class=\"prefix\">OOC:</span> <span class=\"name\">[src.client.stealth ? src.client.fakekey : src.key]:</span> <span class=\"message\">[msg]</span></span>"