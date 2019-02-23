// Couple of helpers to get the RGB of a hexadecimal colour string.
/proc/GetRedPart(var/hexadecimal)
	return hex2num(copytext(hexadecimal, 2, 4))

/proc/GetGreenPart(var/hexadecimal)
	return hex2num(copytext(hexadecimal, 4, 6))

/proc/GetBluePart(var/hexadecimal)
	return hex2num(copytext(hexadecimal, 6))
