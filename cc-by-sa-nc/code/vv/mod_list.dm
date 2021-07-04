/client/proc/mod_list_add(var/list/L)
	var/class = input("What kind of variable?","Variable Type") as null|anything in list("text",
	"num", "type", "reference", "mob reference", "turf by coordinates","new instance of a type", "icon", "file", "color")

	if (!class)
		return

	var/var_value = null

	switch(class)

		if ("text")
			var_value = input("Enter new text:","Text") as null|text

		if ("num")
			var_value = input("Enter new number:","Num") as null|num

		if ("type")
			var_value = input("Enter type:","Type") in null|typesof(/obj,/mob,/area,/turf)

		if ("reference")
			var_value = input("Select reference:","Reference") as null|mob|obj|turf|area in world

		if ("mob reference")
			var_value = input("Select reference:","Reference") as null|mob in world

		if ("file")
			var_value = input("Pick file:","File") as null|file

		if ("icon")
			var_value = input("Pick icon:","Icon") as null|icon

		if ("color")
			var_value = input("Pick color:","Color") as null|color

		if ("turf by coordinates")
			var/x = input("X coordinate", "Set to turf at \[_, ?, ?\]", 1) as null|num
			var/y = input("Y coordinate", "Set to turf at \[[x], _, ?\]", 1) as null|num
			var/z = input("Z coordinate", "Set to turf at \[[x], [y], _\]", 1) as null|num
			var/turf/T = locate(x, y, z)
			if (istype(T))
				var_value = T
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
					var_value = new match()

	if (!var_value) return

	switch(alert("Would you like to associate a var with the list entry?",,"Yes","No"))
		if("Yes")
			L += var_value
			L[var_value] = mod_list_add_ass(L, var_value) //haha
		if("No")
			L += var_value


/client/proc/mod_list_add_ass(var/list/L, var/index) //haha
	var/class = input("What kind of variable?","Variable Type") as null|anything in list("text",
	"num", "type", "reference", "mob reference", "turf by coordinates", "new instance of a type", "icon", "file", "color")

	if (!class)
		return

	var/var_value = null

	switch(class)

		if ("text")
			var_value = input("Enter new text:","Text") as null|text

		if ("num")
			var_value = input("Enter new number:","Num") as null|num

		if ("type")
			var_value = input("Enter type:","Type") in null|typesof(/obj,/mob,/area,/turf)

		if ("reference")
			var_value = input("Select reference:","Reference") as null|mob|obj|turf|area in world

		if ("mob reference")
			var_value = input("Select reference:","Reference") as null|mob in world

		if ("file")
			var_value = input("Pick file:","File") as null|file

		if ("icon")
			var_value = input("Pick icon:","Icon") as null|icon

		if ("color")
			var_value = input("Pick color:","Color") as null|color

		if ("turf by coordinates")
			var/x = input("X coordinate", "Set to turf at \[_, ?, ?\]", 1) as null|num
			var/y = input("Y coordinate", "Set to turf at \[[x], _, ?\]", 1) as null|num
			var/z = input("Z coordinate", "Set to turf at \[[x], [y], _\]", 1) as null|num
			var/turf/T = locate(x, y, z)
			if (istype(T))
				var_value = T
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
					var_value = new match()

	if (!var_value) return

	return var_value
