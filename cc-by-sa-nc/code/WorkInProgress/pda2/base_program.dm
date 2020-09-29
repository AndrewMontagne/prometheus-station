//Eventual plan: Convert all datum/data to datum/computer/file
/datum/computer/file/text
	name = "text"
	extension = "TEXT"
	size = 2.0
	var/data = null

/datum/computer/file/record
	name = "record"
	extension = "REC"

	var/list/fields = list(  )


//base pda program

/datum/computer/file/pda_program
	name = "blank program"
	extension = "PPROG"
	var/obj/item/device/pda2/master = null
	var/id_tag = null

	os
		name = "blank system program"
		extension = "PSYS"

	scan
		name = "blank scan program"
		extension = "PSCAN"

	New(obj/holding as obj)
		if(holding)
			src.holder = holding

			if(istype(src.holder.loc,/obj/item/device/pda2))
				src.master = src.holder.loc

	proc
		return_text()
			if((!src.holder) || (!src.master))
				return TRUE

			if((!istype(holder)) || (!istype(master)))
				return TRUE

			if(!(holder in src.master.contents))
				//world << "Holder [holder] not in [master] of prg:[src]"
				if(master.active_program == src)
					master.active_program = null
				return TRUE

			if(!src.holder.root)
				src.holder.root = new /datum/computer/folder
				src.holder.root.holder = src
				src.holder.root.name = "root"

			return FALSE

		process() //This isn't actually used at the moment
			if((!src.holder) || (!src.master))
				return TRUE

			if((!istype(holder)) || (!istype(master)))
				return TRUE

			if(!(holder in src.master.contents))
				if(master.active_program == src)
					master.active_program = null
				return TRUE

			if(!src.holder.root)
				src.holder.root = new /datum/computer/folder
				src.holder.root.holder = src
				src.holder.root.name = "root"

			return FALSE

		//maybe remove this, I haven't found a good use for it yet
		send_os_command(list/command_list)
			if(!src.master || !src.holder || src.master.host_program || !command_list)
				return TRUE

			if(!istype(src.master.host_program) || src.master.host_program == src)
				return TRUE

			src.master.host_program.receive_os_command()

			return FALSE

		return_text_header()
			if(!src.master || !src.holder)
				return

			var/dat = " | <a href='byond://?src=\ref[src];quit=1'>Main Menu</a>"
			dat += " | <a href='byond://?src=\ref[src.master];refresh=1'>Refresh</a>"

			return dat

		post_signal(datum/signal/signal, newfreq)
			if(master)
				master.post_signal(signal, newfreq)
			else
				del(signal)

		transfer_holder(obj/item/weapon/disk/data/newholder,datum/computer/folder/newfolder)

			if((newholder.file_used + src.size) > newholder.file_amount)
				return FALSE

			if(!newholder.root)
				newholder.root = new /datum/computer/folder
				newholder.root.holder = newholder
				newholder.root.name = "root"

			if(!newfolder)
				newfolder = newholder.root

			if((src.holder && src.holder.read_only) || newholder.read_only)
				return FALSE

			if((src.holder) && (src.holder.root))
				src.holder.root.remove_file(src)

			newfolder.add_file(src)

			if(istype(newholder.loc,/obj/item/device/pda2))
				src.master = newholder.loc

			//world << "Setting [src.holder] to [newholder]"
			src.holder = newholder
			return TRUE


		receive_signal(datum/signal/signal)
			if((!src.holder) || (!src.master))
				return TRUE

			if((!istype(holder)) || (!istype(master)))
				return TRUE

			if(!(holder in src.master.contents))
				if(master.active_program == src)
					master.active_program = null
				return TRUE

			return FALSE


	Topic(href, href_list)
		if((!src.holder) || (!src.master))
			return TRUE

		if((!istype(holder)) || (!istype(master)))
			return TRUE

		if(src.master.active_program != src)
			return TRUE

		if ((!usr.contents.Find(src.master) && (!in_range(src.master, usr) || !istype(src.master.loc, /turf))) && (!istype(usr, /mob/living/silicon)))
			return TRUE

		if(!(holder in src.master.contents))
			if(master.active_program == src)
				master.active_program = null
			return TRUE

		usr.machine = src.master

		if (href_list["close"])
			usr.machine = null
			usr << browse(null, "window=pda2")
			return FALSE

		if (href_list["quit"])
//			src.master.processing_programs.Remove(src)
			if(src.master.host_program && src.master.host_program.holder && (src.master.host_program.holder in src.master.contents))
				src.master.run_program(src.master.host_program)
				src.master.updateSelfDialog()
				return TRUE
			else
				src.master.active_program = null
			src.master.updateSelfDialog()
			return TRUE

		return FALSE
