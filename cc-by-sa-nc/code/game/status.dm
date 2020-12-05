/world/proc/update_status()
	var/s = ""

	s += "<b>Andrew Station 13</b>";
	s += " ("
	s += "<a href=\"https://nanotrasen.space/\">"
	s += "https://nanotrasen.space/"
	s += "</a>"
	s += ")"

	var/list/features = list()

	if (!ticker)
		features += "<b>STARTING</b>"

	var/n = 0
	for (var/mob/M in world)
		if (M.client)
			n++

	if (n > 1)
		features += "~[n] players"
	else if (n > 0)
		features += "~[n] player"

	if (features)
		s += ": [dd_list2text(features, ", ")]"

	/* does this help? I do not know */
	if (src.status != s)
		src.status = s
