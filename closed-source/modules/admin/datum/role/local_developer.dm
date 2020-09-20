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

/datum/role/local_developer/apply_to_client(client/user_client)
	. = ..()

	for(var/path in typesof(/datum/permission))
		var/datum/permission/type = path // Not an instance of /datum/permission, this lets us introspect the initial value for a type
		if (initial(type.name) == null)
			continue

		var/datum/permission/perm = new path()
		perm.assign_to_client(user_client)
