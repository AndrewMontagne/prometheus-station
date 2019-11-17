/world/proc/update_status()
	var/s = ""

	if (config && config.server_name)
		s += "<b>[config.server_name]</b> &#8212; "

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

	/*
	is there a reason for this? the byond site shows 'hosted by X' when there is a proper host already.
	if (host)
		features += "hosted by <b>[host]</b>"
	*/

	if (!host && config && config.hostedby)
		features += "hosted by <b>[config.hostedby]</b>"

	if (features)
		s += ": [dd_list2text(features, ", ")]"

	/* does this help? I do not know */
	if (src.status != s)
		src.status = s
