/mob/proc/stdout(var/text, var/type)
	src.client.stdout(text, type)

/client/proc/stdout(var/text, var/type)
	src << text
