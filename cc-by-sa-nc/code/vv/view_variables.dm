/datum/var/NO_DEBUG = FALSE

/client/proc/debug_variables(datum/D in world)
	set category = "Debug"
	set name = "View Variables"
	set src in world

	var/title = ""
	var/body = ""

	if (!src.has_permission("DEBUG"))
		LOG_ADMIN("[usr.ckey] tried to use VV without the debug permission!")
		src.stdout("You don't have permission to do this")
		return

	title = "[D] (\ref[D]) = [D.type]"

	body += "<ol>"

	var/list/names = list()
	for (var/V in D.vars)
		names += V

	names = sortList(names)

	for (var/V in names)
		body += debug_variable(V, D.vars[V], 0)
		body += " - <a href='byond://?src=\ref[src];Vars=\ref[D];varToEdit=[V]'><font size=1>Edit</font></a> <a href='byond://?src=\ref[src];Vars=\ref[D];varToEditAll=[V]'><font size=1>(A)</font></a>  <a href='byond://?src=\ref[src];Vars=\ref[D];setAll=[V]'><font size=1>(S)</font></a>"
		if (istype(D.vars[V], /datum))
			body += " <a href='byond://?src=\ref[src];Vars=\ref[D];procCall=[V]'><font size=1>(P)</font></a>"

	body += "</ol>"

	var/html = "<html><head>"
	if (title)
		html += "<title>[title]</title>"
	html += {"<style>
body
{
	font-family: Verdana, sans-serif;
	font-size: 9pt;
}
.value
{
	font-family: "Courier New", monospace;
	font-size: 8pt;
}
</style>"}
	html += "</head><body>"
	html += "<a href='byond://?src=\ref[src];Refresh=\ref[D]'>Refresh</a>"
	html += " | <a href='byond://?src=\ref[src];Delete=\ref[D]'>Delete</a>"
	html += " | <a href='byond://?src=\ref[src];CallProc=\ref[D]'>Call Proc</a> <br>"

	html += "<br><a href='byond://?src=\ref[src];SetDirection=\ref[D];DirectionToSet=L90'><<==</a> "
	html += "<a href='byond://?src=\ref[src];SetDirection=\ref[D];DirectionToSet=L45'><=</a> "
	html += "<a href='byond://?src=\ref[src];SetDirection=\ref[D]'>Set Direction</a> "
	html += "<a href='byond://?src=\ref[src];SetDirection=\ref[D];DirectionToSet=R45'>=></a> "
	html += "<a href='byond://?src=\ref[src];SetDirection=\ref[D];DirectionToSet=R90'>==>></a><br>"

	html += "<br><small> (A) = Edit all entities of same type <br> (S) = Set this var on all entities of same type <br> (P) = Call Proc</small>"
	html += body
	html += "</body></html>"

	usr << browse(html, "window=variables\ref[D]")

	return

/client/proc/debug_variable(name, value, level)
	var/html = ""

	html += "<li>"

	if (isnull(value))
		html += "[name] = <span class='value'>null</span>"

	else if (istext(value))
		html += "[name] = <span class='value'>\"[value]\"</span>"

	else if (isicon(value))
		#ifdef VARSICON
		var/icon/I = new/icon(value)
		var/rnd = rand(1,10000)
		var/rname = "tmp\ref[I][rnd].png"
		usr << browse_rsc(I, rname)
		html += "[name] = (<span class='value'>[value]</span>) <img class=icon src=\"[rname]\">"
		#else
		html += "[name] = /icon (<span class='value'>[value]</span>)"
		#endif

	else if (isfile(value))
		html += "[name] = <span class='value'>'[value]'</span>"

	else if (istype(value, /datum))
		var/datum/D = value
		var/dname = null
		if ("name" in D.vars)
			dname = " (" + D.vars["name"] + ")"
		html += "<a href='byond://?src=\ref[src];Vars=\ref[value]'>[name] \ref[value]</a> = [D.type][dname]"

	else if (istype(value, /client))
		var/client/C = value
		html += "<a href='byond://?src=\ref[src];Vars=\ref[value]'>[name] \ref[value]</a> = [C] [C.type]"

	else if (islist(value))
		var/list/L = value
		html += "[name] = /list ([L.len])"
		var/list/forbidden_vars = list("underlays", "overlays", "vars", "verbs")
		if (!isnull(L) && L.len > 0 && !(name in forbidden_vars || L.len > 500))
			html += "<ul>"
			for (var/index = 1, index <= L.len, index++)
				html += debug_variable("[index]", L[index], level + 1)
				var/list/forbidden_vars2 = list("contents", "vis_contents", "vis_locs")
				if (!(name in forbidden_vars2) && !isnum(L[index]) && L["[L[index]]"])
					html += "[debug_variable("&nbsp;&nbsp;&nbsp;", L["[L[index]]"], level + 1)]"
			html += "</ul>"
	else
		html += "[name] = <span class='value'>[value]</span>"

	html += "</li>"

	return html

/client/Topic(href, href_list, hsrc)
	if (href_list["Refresh"])
		src.debug_variables(locate(href_list["Refresh"]))
	if (href_list["Delete"])
		var/atom/A = locate(href_list["Delete"])
		del(A)
	if (href_list["SetDirection"])
		var/atom/A = locate(href_list["SetDirection"])
		if (istype(A))
			var/new_dir = href_list["DirectionToSet"]
			if (new_dir == "L90")
				A.dir = turn(A.dir, 90)
				src.stdout( "Turned [A] 90° to the left: direction is now [uppertext(dir2text(A.dir))].")
			else if (new_dir == "L45")
				A.dir = turn(A.dir, 45)
				src.stdout( "Turned [A] 45° to the left: direction is now [uppertext(dir2text(A.dir))].")
			else if (new_dir == "R90")
				A.dir = turn(A.dir, -90)
				src.stdout( "Turned [A] 90° to the right: direction is now [uppertext(dir2text(A.dir))].")
			else if (new_dir == "R45")
				A.dir = turn(A.dir, -45)
				src.stdout( "Turned [A] 45° to the right: direction is now [uppertext(dir2text(A.dir))].")
			else
				var/list/english_dirs = list("NORTH", "NORTHEAST", "EAST", "SOUTHEAST", "SOUTH", "SOUTHWEST", "WEST", "NORTHWEST")
				new_dir = input(src, "Choose a direction for [A] to face.", "Selection", "NORTH") as null|anything in english_dirs
				if (new_dir)
					A.dir = text2dir(new_dir)
					src.stdout( "Set [A]'s direction to [new_dir]")
		return
	if (href_list["CallProc"])
		doCallProc(locate(href_list["CallProc"]))
		return
	if (href_list["Vars"])
		if (href_list["varToEdit"])
			modify_variable(locate(href_list["Vars"]), href_list["varToEdit"])
		else if (href_list["varToEditAll"])
			modify_variable(locate(href_list["Vars"]), href_list["varToEditAll"], 1)
		else if (href_list["setAll"])
			set_all(locate(href_list["Vars"]), href_list["setAll"])
		else if (href_list["procCall"])
			var/datum/D = locate(href_list["Vars"])
			if (D)
				var/datum/C = D.vars[href_list["procCall"]]
				if (istype(C, /datum))
					doCallProc(C)
		else
			debug_variables(locate(href_list["Vars"]))
	else
		..()

/client/proc/set_all(datum/D, variable)
	if(!variable || !D || !(variable in D.vars))
		return

	if (!src.has_permission("DEBUG"))
		LOG_ADMIN("[usr.ckey] tried to use VV without the debug permission!")
		src.stdout("You don't have permission to do this")
		return

	var/var_value = D.vars[variable]

	for(var/x in world)
		if(!istype(x, D.type)) continue
		x:vars[variable] = var_value
		sleep(1)

/client/proc/modify_variable(datum/D, variable, set_global = 0)
	if(!variable || !D || !(variable in D.vars))
		return

	if (!src.has_permission("DEBUG"))
		LOG_ADMIN("[usr.ckey] tried to use VV without the debug permission!")
		src.stdout("You don't have permission to do this")
		return

	var/default
	var/var_value = D.vars[variable]
	var/dir

	if (!src.has_permission("DEBUG"))
		LOG_ADMIN("[usr.ckey] tried to use VV without the debug permission!")
		src.stdout("You don't have permission to do this")
		return

#ifdef ENV_BUILD_RELEASE
	//Let's prevent people from promoting themselves, yes?
	if (initial(D.NO_DEBUG) == TRUE || D.NO_DEBUG == TRUE)
		usr.stdout( "<span style=\"color:red\">You're not allowed to edit [D.type] for security reasons!</span>")
		//logTheThing("admin", usr, null, "tried to varedit [D.type] but was denied!")
		//logTheThing("diary", usr, null, "tried to varedit [D.type] but was denied!", "admin")
		//message_admins("[key_name(usr)] tried to varedit [D.type] but was denied.") //If someone tries this let's make sure we all know it.
		return
#endif

	if (isnull(var_value))
		usr.stdout( "Unable to determine variable type.")

	else if (isnum(var_value))
		usr.stdout( "Variable appears to be <b>NUM</b>.")
		default = "num"
		dir = 1

	else if (is_valid_color_string(var_value))
		usr.stdout( "Variable appears to be <b>COLOR</b>.")
		default = "color"

	else if (istext(var_value))
		usr.stdout( "Variable appears to be <b>TEXT</b>.")
		default = "text"

	else if (isloc(var_value))
		usr.stdout( "Variable appears to be <b>REFERENCE</b>.")
		default = "reference"

	else if (isicon(var_value))
		usr.stdout( "Variable appears to be <b>ICON</b>.")
		//var_value = "[bicon(var_value)]"
		default = "icon"

	else if (istype(var_value,/atom) || istype(var_value,/datum))
		usr.stdout( "Variable appears to be <b>TYPE</b>.")
		default = "type"

	else if (islist(var_value))
		usr.stdout( "Variable appears to be <b>LIST</b>.")
		default = "list"

	else if (istype(var_value,/client))
		usr.stdout( "Variable appears to be <b>CLIENT</b>.")
		default = "cancel"

	else
		usr.stdout( "Variable appears to be <b>FILE</b>.")
		default = "file"

	usr.stdout( "Variable contains: [var_value]")
	if(dir)
		switch(var_value)
			if(1)
				dir = "NORTH"
			if(2)
				dir = "SOUTH"
			if(4)
				dir = "EAST"
			if(8)
				dir = "WEST"
			if(5)
				dir = "NORTHEAST"
			if(6)
				dir = "SOUTHEAST"
			if(9)
				dir = "NORTHWEST"
			if(10)
				dir = "SOUTHWEST"
			else
				dir = null
		if(dir)
			usr.stdout( "If a direction, direction is: [dir]")

	var/class = input("What kind of variable?","Variable Type",default) as null|anything in list("text",
		"num","type","reference","mob reference","turf by coordinates","new instance of a type","icon","file","color","list","edit referenced object","create new list","restore to default")

	if(!class)
		return

	var/original_name

	if (!istype(D, /atom))
		original_name = "\ref[D] ([D])"
	else
		original_name = D:name

	var/oldVal = D.vars[variable]
	switch(class)

		if("list")
			mod_list(D.vars[variable])
			//return <- Way to screw up logging

		if("restore to default")
			if(set_global)
				for(var/x in world)
					if(!istype(x, D.type)) continue
					x:vars[variable] = initial(x:vars[variable])
			else
				D.vars[variable] = initial(D.vars[variable])

		if("edit referenced object")
			return .(D.vars[variable])

		if("create new list")
			if(set_global)
				for(var/x in world)
					if(!istype(x, D.type)) continue
					x:vars[variable] = list()
			else
				D.vars[variable] = list()

		if("text")
			var/theInput = input("Enter new text:","Text", D.vars[variable]) as null|text
			if(theInput == null) return
			if(set_global)
				for(var/x in world)
					if(!istype(x, D.type)) continue
					x:vars[variable] = theInput
			else
				D.vars[variable] = theInput

		if("num")
			var/theInput = input("Enter new number:","Num", D.vars[variable]) as null|num
			if(theInput == null) return
			if(set_global)
				for(var/x in world)
					if(!istype(x, D.type)) continue
					x:vars[variable] = theInput
			else
				D.vars[variable] = theInput

		if("type")
			var/theInput = input("Enter type:","Type",D.vars[variable]) in null|typesof(/obj,/mob,/area,/turf)
			if(theInput == null) return
			if(set_global)
				for(var/x in world)
					if(!istype(x, D.type)) continue
					x:vars[variable] = theInput
			else
				D.vars[variable] = theInput

		if("reference")
			var/theInput = input("Select reference:","Reference", D.vars[variable]) as null|mob|obj|turf|area in world
			if(theInput == null) return
			if(set_global)
				for(var/x in world)
					if(!istype(x, D.type)) continue
					x:vars[variable] = theInput
			else
				D.vars[variable] = theInput

		if("mob reference")
			var/theInput = input("Select reference:","Reference", D.vars[variable]) as null|mob in world
			if(theInput == null) return
			if(set_global)
				for(var/x in world)
					if(!istype(x, D.type)) continue
					x:vars[variable] = theInput
			else
				D.vars[variable] = theInput

		if("file")
			var/theInput = input("Pick file:","File",D.vars[variable]) as null|file
			if(theInput == null) return
			if(set_global)
				for(var/x in world)
					if(!istype(x, D.type)) continue
					x:vars[variable] = theInput
			else
				D.vars[variable] = theInput

		if("icon")
			var/theInput = input("Pick icon:","Icon",D.vars[variable]) as null|icon
			if(theInput == null) return
			if(set_global)
				for(var/x in world)
					if(!istype(x, D.type)) continue
					x:vars[variable] = theInput
			else
				D.vars[variable] = theInput

		if("color")
			var/theInput = input("Pick color:","Color",D.vars[variable]) as null|color
			if(theInput == null) return
			if(set_global)
				for(var/x in world)
					if(!istype(x, D.type)) continue
					x:vars[variable] = theInput
			else
				D.vars[variable] = theInput

		if("turf by coordinates")
			var/x = input("X coordinate", "Set to turf at \[_, ?, ?\]", 1) as num
			var/y = input("Y coordinate", "Set to turf at \[[x], _, ?\]", 1) as num
			var/z = input("Z coordinate", "Set to turf at \[[x], [y], _\]", 1) as num
			var/turf/T = locate(x, y, z)
			if (istype(T))
				if (set_global)
					for (var/datum/q in world)
						if (!istype(q, D.type)) continue
						q.vars[variable] = T
				else
					D.vars[variable] = T
			else
				usr.stdout( "<span style=\"color:red\">Invalid coordinates!</span>")
				return

		if ("new instance of a type")
			usr.stdout("<span style=\"color:blue\">Type part of the path of type of thing to instantiate.</span>")
			var/typename = input("Part of type path.", "Part of type path.", "/obj") as null|text
			if (typename)
				var/basetype = /datum
				var/match = get_one_match(typename, basetype)
				if (match)
					if (set_global)
						for (var/datum/x in world)
							if (!istype(x, D.type)) continue
							x.vars[variable] = new match(x)
					else
						D.vars[variable] = new match(D)
			else
				return
	LOG_ADMIN("[usr.ckey] modified [original_name]'s [variable] to [D.vars[variable]]" + (set_global ? " on all entities of same type" : ""))
	//logTheThing("admin", src, null, "modified [original_name]'s [variable] to [D.vars[variable]]" + (set_global ? " on all entities of same type" : ""))
	//logTheThing("diary", src, null, "modified [original_name]'s [variable] to [D.vars[variable]]" + (set_global ? " on all entities of same type" : ""), "admin")
	//message_admins("[key_name(src)] modified [original_name]'s [variable] to [D.vars[variable]]" + (set_global ? " on all entities of same type" : ""), 1)
	spawn(0)
		if (istype(D, /datum))
			D.onVarChanged(variable, oldVal, D.vars[variable])
	src.debug_variables(D)

/mob/proc/Delete(atom/A in view())
	set category = "Debug"
	switch (alert("Are you sure you wish to delete \the [A.name] at ([A.x],[A.y],[A.z]) ?", "Admin Delete Object","Yes","No"))
		if("Yes")
			LOG_ADMIN("[usr.ckey] deleted [A.name] at ([A.x],[A.y],[A.z])")
			//logTheThing("admin", usr, null, "deleted [A.name] at ([showCoords(A.x, A.y, A.z)])")
			//logTheThing("diary", usr, null, "deleted [A.name] at ([showCoords(A.x, A.y, A.z, 1)])", "admin")

/client/proc/modify_variables(var/atom/O)

	var/list/names = list()
	for (var/V in O.vars)
		names += V

	names = sortList(names)

	var/variable = input("Which var?","Var") as null|anything in names
	if(!variable)
		return
	var/default
	var/var_value = O.vars[variable]
	var/dir

	//Let's prevent people from promoting themselves, yes?
#ifdef ENV_BUILD_RELEASE
	//Let's prevent people from promoting themselves, yes?
	if (initial(O.NO_DEBUG) == TRUE || O.NO_DEBUG == TRUE)
		usr.stdout( "<span style=\"color:red\">You're not allowed to edit [O.type] for security reasons!</span>")
		//logTheThing("admin", usr, null, "tried to varedit [D.type] but was denied!")
		//logTheThing("diary", usr, null, "tried to varedit [D.type] but was denied!", "admin")
		//message_admins("[key_name(usr)] tried to varedit [D.type] but was denied.") //If someone tries this let's make sure we all know it.
		return
#endif
	if (isnull(var_value))
		usr.stdout( "Unable to determine variable type.")

	else if (isnum(var_value))
		usr.stdout( "Variable appears to be <b>NUM</b>.")
		default = "num"
		dir = 1

	else if (is_valid_color_string(var_value))
		usr.stdout( "Variable appears to be <b>COLOR</b>.")
		default = "color"

	else if (istext(var_value))
		usr.stdout( "Variable appears to be <b>TEXT</b>.")
		default = "text"

	else if (ispath(var_value))
		usr.stdout( "Variable appears to be <B>TYPE</b>.")
		default = "type"

	else if (ismob(var_value))
		usr.stdout( "Variable appears to be <B>MOB REFERENCE</b>.")
		default = "mob reference"

	else if (isloc(var_value))
		usr.stdout( "Variable appears to be <b>REFERENCE</b>.")
		default = "reference"

	else if (isicon(var_value))
		usr.stdout( "Variable appears to be <b>ICON</b>.")
		//var_value = "[bicon(var_value)]" //Wire: Bug me if you want the entirely too long winded explanation of why this is commented out
		default = "icon"

	else if (isfile(var_value))
		usr.stdout( "Variable appears to be <b>FILE</b>.")
		default = "file"

	else if (islist(var_value))
		usr.stdout( "Variable appears to be <b>LIST</b>.")
		default = "list"

	else if (istype(var_value,/client))
		usr.stdout( "Variable appears to be <b>CLIENT</b>.")
		default = "cancel"

	else
		usr.stdout( "Variable appears to be <b>DATUM</b>.")
		default = "edit referenced object"

	usr.stdout( "Variable contains: [var_value]")
	if(dir)
		switch(var_value)
			if(1)
				dir = "NORTH"
			if(2)
				dir = "SOUTH"
			if(4)
				dir = "EAST"
			if(8)
				dir = "WEST"
			if(5)
				dir = "NORTHEAST"
			if(6)
				dir = "SOUTHEAST"
			if(9)
				dir = "NORTHWEST"
			if(10)
				dir = "SOUTHWEST"
			else
				dir = null
		if(dir)
			usr.stdout( "If a direction, direction is: [dir]")

	var/class = input("What kind of variable?","Variable Type",default) as null|anything in list("text",
		"num","type","reference","mob reference","turf by coordinates","new instance of a type","icon","file","color","list","edit referenced object","create new list","restore to default")

	if(!class)
		return

	var/original_name

	if (!istype(O, /atom))
		original_name = "\ref[O] ([O])"
	else
		original_name = O:name

	var/oldVal = O.vars[variable]
	switch(class)

		if("list")
			mod_list(O.vars[variable])
			return

		if("restore to default")
			O.vars[variable] = initial(O.vars[variable])

		if("edit referenced object")
			return .(O.vars[variable])

		if("create new list")
			O.vars[variable] = list()

		if("text")
			O.vars[variable] = input("Enter new text:","Text",\
				O.vars[variable]) as text

		if("num")
			O.vars[variable] = input("Enter new number:","Num",\
				O.vars[variable]) as num

		if("type")
			O.vars[variable] = input("Enter type:","Type",O.vars[variable]) \
				in typesof(/obj,/mob,/area,/turf)

		if("reference")
			O.vars[variable] = input("Select reference:","Reference",\
				O.vars[variable]) as mob|obj|turf|area in world

		if("mob reference")
			O.vars[variable] = input("Select reference:","Reference",\
				O.vars[variable]) as mob in world

		if("turf by coordinates")
			var/x = input("X coordinate", "Set to turf at \[_, ?, ?\]", 1) as num
			var/y = input("Y coordinate", "Set to turf at \[[x], _, ?\]", 1) as num
			var/z = input("Z coordinate", "Set to turf at \[[x], [y], _\]", 1) as num
			var/turf/T = locate(x, y, z)
			if (istype(T))
				O.vars[variable] = T
			else
				usr.stdout( "<span style=\"color:red\">Invalid coordinates!</span>")
				return

		if ("new instance of a type")
			usr.stdout( "<span style=\"color:blue\">Type part of the path of type of thing to instantiate.</span>")
			var/typename = input("Part of type path.", "Part of type path.", "/obj") as null|text
			if (typename)
				var/basetype = /datum
				var/match = get_one_match(typename, basetype)
				if (match)
					O.vars[variable] = new match(O)

		if("file")
			O.vars[variable] = input("Pick file:","File",O.vars[variable]) \
				as file

		if("icon")
			O.vars[variable] = input("Pick icon:","Icon",O.vars[variable]) \
				as icon

		if("color")
			O.vars[variable] = input("Pick color:","Color",O.vars[variable]) \
				as color

	LOG_ADMIN("[usr.ckey] modified [original_name]'s [variable] to [O.vars[variable]]")
	//logTheThing("admin", src, null, "modified [original_name]'s [variable] to [O.vars[variable]]")
	//logTheThing("diary", src, null, "modified [original_name]'s [variable] to [O.vars[variable]]", "admin")
	//message_admins("[key_name(src)] modified [original_name]'s [variable] to [O.vars[variable]]")
	spawn(0)
		O.onVarChanged(variable, oldVal, O.vars[variable])


/client/proc/call_proc()
	set category = "Debug"
	set name = "Advanced ProcCall"
	var/target = null

	switch (alert("Proc owned by obj?",,"Yes","No","Cancel"))
		if ("Cancel")
			return
		if ("Yes")
			target = input("Enter target:","Target",null) as null|obj|mob|area|turf in world
			if (!target)
				return
		if ("No")
			target = null
	doCallProc(target)

/proc/doCallProc(target = null)
	var/returnval = null
	var/procname = input("Procpath","path:", null) as null|text
	if (isnull(procname))
		return

	var/argnum = input("Number of arguments:","Number", 0) as null|num
	if (isnull(argnum))
		return

	var/list/listargs = list()

	for(var/i=0, i<argnum, i++)
		var/class = input("Type of Argument #[i]","Variable Type", null) in list("text","num","type","reference","mob reference","reference atom at current turf","icon","file","cancel")
		switch(class)
			if("-cancel-")
				return

			if("text")
				listargs += input("Enter new text:","Text",null) as null|text

			if("num")
				listargs += input("Enter new number:","Num", 0) as null|num

			if("type")
				listargs += input("Enter type:","Type", null) in null|typesof(/obj,/mob,/area,/turf)

			if("reference")
				listargs += input("Select reference:","Reference", null) as null|mob|obj|turf|area in world

			if("mob reference")
				listargs += input("Select reference:","Reference", null) as null|mob in world

			if("reference atom at current turf")
				var/list/possible = list()
				var/turf/T = usr.find_turf()
				possible += T.loc
				possible += T
				for (var/atom/A in T)
					possible += A
					for (var/atom/B in A)
						possible += B
				listargs += input("Select reference:","Reference", null) as mob|obj|turf|area in possible

			if("file")
				listargs += input("Pick file:","File", null) as null|file

			if("icon")
				listargs += input("Pick icon:","Icon", null) as null|icon
		if (listargs == null) return
	if (target)
		usr.stdout( "<span style=\"color:blue\">Calling '[procname]' with [listargs.len] arguments on '[target]'</span>")
		if(listargs.len)
			returnval = call(target,procname)(arglist(listargs))
		else
			returnval = call(target,procname)()
	else
		usr.stdout( "<span style=\"color:blue\">Calling '[procname]' with [listargs.len] arguments</span>")
		if(listargs.len)
			returnval = call(procname)(arglist(listargs))
		else
			returnval = call(procname)(arglist(listargs))

	usr.stdout( "<span style=\"color:blue\">Proc returned: [returnval ? returnval : "null"]</span>")
	return

/client/proc/mod_list(var/list/L)
	if(!islist(L)) src.stdout("Not a List.")

	var/list/names = sortList(L)

	var/list/fixedList = new/list()

	for(var/x in names)
		var/addNew = istext(x) ? (isnull(L[x]) ? "\ref[x] - ([x])" : "\ref[x] -> ([L[x]])") : "\ref[x] - ([x])"
		fixedList.Add(addNew)
		fixedList[addNew] = x

	var/variable = input("Which var?","Var") as null|anything in fixedList + "(ADD VAR)"

	if(variable == "(ADD VAR)")
		mod_list_add(L)
		return

	if(!variable)
		return

	variable = fixedList[variable]
	var/variable_index = L.Find(variable)
	var/default

	var/dir

	if (isnull(variable))
		usr.stdout("Unable to determine variable type.")

	else if (L[variable] != null)
		usr.stdout("Variable appears to be an associated list entry.")
		default = "associated"
		dir = 1

	else if (isnum(variable))
		usr.stdout("Variable appears to be <b>NUM</b>.")
		default = "num"
		dir = 1

	else if (is_valid_color_string(variable))
		usr.stdout("Variable appears to be <b>COLOR</b>.")
		default = "color"

	else if (istext(variable))
		usr.stdout("Variable appears to be <b>TEXT</b>.")
		default = "text"

	else if (isloc(variable))
		usr.stdout("Variable appears to be <b>REFERENCE</b>.")
		default = "reference"

	else if (isicon(variable))
		usr.stdout("Variable appears to be <b>ICON</b>.")
		//variable = "[bicon(variable)]" //Wire: Bug me if you want the entirely too long winded explanation of why this is commented out
		default = "icon"

	else if (istype(variable,/atom) || istype(variable,/datum))
		usr.stdout("Variable appears to be <b>TYPE</b>.")
		default = "type"

	else if (islist(variable))
		usr.stdout("Variable appears to be <b>LIST</b>.")
		default = "list"

	else if (istype(variable,/client))
		usr.stdout("Variable appears to be <b>CLIENT</b>.")
		default = "cancel"

	else
		usr.stdout("Variable appears to be <b>FILE</b>.")
		default = "file"

	usr.stdout("Variable contains: [variable]")
	if(dir)
		switch(variable)
			if(1)
				dir = "NORTH"
			if(2)
				dir = "SOUTH"
			if(4)
				dir = "EAST"
			if(8)
				dir = "WEST"
			if(5)
				dir = "NORTHEAST"
			if(6)
				dir = "SOUTHEAST"
			if(9)
				dir = "NORTHWEST"
			if(10)
				dir = "SOUTHWEST"
			else
				dir = null

		if(dir)
			usr.stdout("If a direction, direction is: [dir]")

	var/class = input("What kind of variable?","Variable Type",default) as null|anything in list("text",
		"num","type","reference","mob reference","turf by coordinates","new instance of a type", "icon","file","color","list","edit referenced object", default == "associated" ? "associated" : null, "(DELETE FROM LIST)","restore to default")

	if(!class)
		return

	switch(class)

		if("associated")
			modify_variables(L[variable])

		if("list")
			mod_list(variable)

		if("restore to default")
			L[variable_index] = initial(variable)

		if("edit referenced object")
			modify_variables(L[variable_index])

		if("(DELETE FROM LIST)")
			L -= variable
			return

		if("text")
			L[variable_index] = input("Enter new text:","Text",\
				variable) as text

		if("num")
			L[variable_index] = input("Enter new number:","Num",\
				variable) as num

		if("type")
			L[variable_index] = input("Enter type:","Type",variable) \
				in typesof(/obj,/mob,/area,/turf)

		if("reference")
			L[variable_index] = input("Select reference:","Reference",\
				variable) as mob|obj|turf|area in world

		if("mob reference")
			L[variable_index] = input("Select reference:","Reference",\
				variable) as mob in world

		if("turf by coordinates")
			var/x = input("X coordinate", "Set to turf at \[_, ?, ?\]", 1) as num
			var/y = input("Y coordinate", "Set to turf at \[[x], _, ?\]", 1) as num
			var/z = input("Z coordinate", "Set to turf at \[[x], [y], _\]", 1) as num
			var/turf/T = locate(x, y, z)
			if (istype(T))
				L[variable_index] = T
			else
				usr.stdout("<span style=\"color:red\">Invalid coordinates!</span>")
				return

		if ("new instance of a type")
			usr.stdout("<span style=\"color:blue\">Type part of the path of type of thing to instantiate.</span>")
			var/typename = input("Part of type path.", "Part of type path.", "/obj") as null|text
			if (typename)
				var/basetype = /datum
				var/match = get_one_match(typename, basetype)
				if (match)
					L[variable_index] = new match()

		if("file")
			L[variable_index] = input("Pick file:","File",variable) \
				as file

		if("icon")
			L[variable_index] = input("Pick icon:","Icon",variable) \
				as icon

		if("color")
			L[variable_index] = input("Pick color:","Color",variable) \
				as color


