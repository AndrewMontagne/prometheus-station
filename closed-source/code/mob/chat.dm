
/mob/verb/ooc(message as text)
	src.send_event("ooc_message", "[src.ckey]: [message]")

/mob/proc/init_chat()
	src.subscribe_to_events("ooc_message")

/mob/player/proc/recv_ooc_message(var/payload)
	src << payload

