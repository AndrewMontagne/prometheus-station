/// Shows and hides the web browser overlay on the client as needed
/client/verb/infotab_change(var/new_tab="" as null|text)
	set name = "OnInfoTabChange"
	set hidden = TRUE

	if (new_tab == "MOTD")
		winset(src, "infobrowser", "is-visible=true;")
		src << browse("<html><body>[motd]</body></html>", "window=infobrowser")
	else
		winset(src, "infobrowser", "is-visible=false;")

	if (new_tab == "Inventory")
		winset(src, "inventorymap", "is-visible=true;")
	else
		winset(src, "inventorymap", "is-visible=false;")

/// Sets up the hook into the frontend to call the OnInfoTabChange verb
/client/proc/init_infobrowser()
    winset(src, "info", "on-tab = \"OnInfoTabChange \[\[*\]\]\"")

/// Dummy verb for the MOTD tab
/client/verb/dummy_motd_verb()
	set name = "Loading MOTD..."
	set category = "MOTD"
	return

/// Dummy verb for the MOTD tab
/client/verb/dummy_inventory_verb()
	set name = "Loading Inventory..."
	set category = "Inventory"
	return
