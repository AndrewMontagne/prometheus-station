/// Converts a given number to a hex string
/proc/num2hex(num, placeholder)
	if (placeholder == null)
		placeholder = 2
	if (!( isnum(num) ))
		CRASH("num2hex not given a numeric argument (user error)")
	if (!( num ))
		return "0"
	var/hex = ""
	var/i = 0
	while(16 ** i < num)
		i++
	var/power = null
	power = i - 1
	while(power >= 0)
		var/val = round(num / 16 ** power)
		num -= val * 16 ** power
		switch(val)
			if(9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0, 0.0)
				hex += text("[]", val)
			if(10.0)
				hex += "A"
			if(11.0)
				hex += "B"
			if(12.0)
				hex += "C"
			if(13.0)
				hex += "D"
			if(14.0)
				hex += "E"
			if(15.0)
				hex += "F"
			else
		power--
	while(length(hex) < placeholder)
		hex = text("0[]", hex)
	return hex

/proc/clear_nulls(var/list/L)
	while (null in L)
		L.Remove(null)

/proc/unitize(var/value, var/unit, var/min_base=0, var/max_base=12)
	if (!isnum(value))
		value = 0

	if (value == 0)
		return "0 [unit]"

	var/list/prefixes = list("p","n","μ","m","","k","M","G","T")
	var/base = log(10, value)
	base = round(base, 3)
	base = clamp(base, min_base, max_base)

	if (base == 0)
		return "[round(value, 0.01)] [unit]"

	var/modified_value = value / (10 ** base)
	var/index = clamp((base / 3) + 5, 1, prefixes.len)

	return "[round(modified_value, 0.01)] [prefixes[index]][unit]"

/proc/angle_to_dir(var/angle)
	if (angle < -135 || angle > 135)
		return WEST
	else if (angle < -45)
		return SOUTH
	else if (angle > 45)
		return NORTH
	else
		return EAST

/proc/invert_dir(var/dir)
	switch (dir)
		if (NORTH) 		return SOUTH
		if (NORTHEAST) 	return SOUTHWEST
		if (EAST) 		return WEST
		if (SOUTHEAST) 	return NORTHWEST
		if (SOUTH) 		return NORTH
		if (SOUTHWEST) 	return NORTHEAST
		if (WEST) 		return EAST
		if (NORTHWEST) 	return SOUTHEAST
		else 			return dir

/proc/invert_dir_str(var/dir)
	var/numdir = text2num(dir)
	return "[invert_dir(numdir)]"
