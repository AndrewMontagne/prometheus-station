/mob/verb/infotab_change(var/new_tab="" as null|text)
	set name = "OnInfoTabChange"
	set category = "MOTD"

	if (new_tab == "MOTD")
		winset(src, "infobrowser", "is-visible=true;")
		src << browse("<html><body>[join_motd]</body></html>", "window=infobrowser")
	else
		winset(src, "infobrowser", "is-visible=false;")

/client/proc/init_infobrowser()
    winset(src, "info", "on-tab = \"OnInfoTabChange \[\[*\]\]\"")