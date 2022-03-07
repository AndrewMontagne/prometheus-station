/// Outputs a given string to the client of a given mob.
/mob/proc/stdout(var/text, var/type)
	if (src.client)
		src.client.stdout(text, type)

/// Outputs a given string to a client.
/client/proc/stdout(var/text, var/type)
	src << text
