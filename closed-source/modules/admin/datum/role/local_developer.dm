/datum/role/local_developer
	priority = 0
	role_name = "Local Developer"

/datum/role/local_developer/is_client_eligible(client/user_client)
	var/list/address_components = splittext(user_client.address, ".")
	var/address_A = text2num(address_components[1])
	var/address_B = text2num(address_components[2])

	if (address_A == 127)
		return TRUE
	if (address_A == 10)
		return TRUE
	if (address_A == 192 && address_B == 168)
		return TRUE
	if (address_A == 172 && (address_B >= 16 && address_B <= 31))
		return TRUE

	return FALSE
