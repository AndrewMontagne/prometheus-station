/proc/text2dir(direction)
	switch(uppertext(direction))
		if("NORTH")
			return NORTH
		if("SOUTH")
			return SOUTH
		if("EAST")
			return EAST
		if("WEST")
			return WEST
		if("NORTHEAST")
			return NORTHEAST
		if("NORTHWEST")
			return NORTHWEST
		if("SOUTHEAST")
			return SOUTHEAST
		if("SOUTHWEST")
			return SOUTHWEST
		else
	return

/proc/dir2text(direction)
	switch(direction)
		if(NORTH)
			return "north"
		if(SOUTH)
			return "south"
		if(EAST)
			return "east"
		if(WEST)
			return "west"
		if(NORTHEAST)
			return "northeast"
		if(SOUTHEAST)
			return "southeast"
		if(NORTHWEST)
			return "northwest"
		if(SOUTHWEST)
			return "southwest"
		else
	return

/proc/mergeLists(var/list/L, var/list/R)
	var/Li=1
	var/Ri=1
	. = list()
	while(Li <= L.len && Ri <= R.len)
		if(sorttext(L[Li], R[Ri]) < 1)
			var/key = R[Ri]
			var/ass = !isnum(key) ? R[key] : null //Associative lists. (also hurf durf)
			. += R[Ri++]
			if(ass) .[key] = ass
		else
			var/key = L[Li]
			var/ass = !isnum(key) ? L[key] : null //Associative lists. (also hurf durf)
			. += L[Li++]
			if(ass) .[key] = ass

	if(Li <= L.len)
		. += L.Copy(Li, 0)
	else
		. += R.Copy(Ri, 0)

/proc/sortList(var/list/L)
	if(L.len < 2)
		return L
	var/middle = L.len / 2 + 1 // Copy is first,second-1
	. = mergeLists(sortList(L.Copy(0,middle)), sortList(L.Copy(middle))) //second parameter null = to end of list

/proc/is_valid_color_string(var/string)
	if (!istext(string))
		return FALSE
	if (length(string) != 7)
		return FALSE
	if (copytext(string,1,2) != "#")
		return FALSE
	if (!ishex(copytext(string,2,8)))
		return FALSE
	return TRUE

/proc/get_matches_string(var/text, var/list/possibles)
	var/list/matches = new()
	for (var/possible in possibles)
		if (findtext(possible, text))
			matches += possible

	return matches

/proc/get_one_match_string(var/text, var/list/possibles)
	var/list/matches = get_matches_string(text, possibles)
	if (matches.len == 0)
		return null
	var/chosen
	if (matches.len == 1)
		chosen = matches[1]
	else
		chosen = input("Select a match", "matches for pattern", null) as null|anything in matches
		if (!chosen)
			return null

	return chosen

/proc/get_matches(var/object, var/base = /atom)
	var/list/types = typesof(base)

	var/list/matches = new()

	for(var/path in types)
		if(findtext("[path]", object))
			matches += path

	return matches

/proc/get_one_match(var/object, var/base = /atom)
	var/list/matches = get_matches(object, base)

	if(matches.len==0)
		return null

	var/chosen
	if(matches.len==1)
		chosen = matches[1]
	else
		var/safe_matches = matches - list(/database, /client, /icon, /sound, /savefile)
		chosen = input("Select an atom type", "Matches for pattern", null) as null|anything in safe_matches
		if(!chosen)
			return null

	return chosen

/proc/ishex(hex)
	if (!( istext(hex) ))
		return FALSE
	hex = lowertext(hex)
	var/list/hex_list = list("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f")
	var/i = null
	i = length(hex)
	while(i > 0)
		var/char = copytext(hex, i, i + 1)
		if(!(char in hex_list))
			return FALSE
		i--
	return TRUE

/datum/proc/onVarChanged(variable, oldval, newval)
