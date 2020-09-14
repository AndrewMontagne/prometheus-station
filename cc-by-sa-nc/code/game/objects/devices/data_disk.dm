/obj/item/weapon/disk/data
	name = "data disk"
	icon = 'cc-by-sa-nc/icons/obj/cloning.dmi'
	icon_state = "datadisk0" //Gosh I hope syndies don't mistake them for the nuke disk.
	item_state = "card-id"
	w_class = 1.0
	var/data = ""
	var/ue = 0
	var/data_type = "ui" //ui|se
	var/owner = "Farmer Jeff"
	var/read_only = 0 //Well,it's still a floppy disk