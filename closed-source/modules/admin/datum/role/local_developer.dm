//! Local developer role
/datum/role/local_developer
	priority = 0
	role_name = "Local Developer"

//! If the client's IP range is in an IANA-assigned private network block or the loopback block, give them this.
/datum/role/local_developer/is_client_eligible(client/user_client)
	//TODO: Config check to make sure this can never be invoked on production

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

//! The local developer role gets every single possible permission.
/datum/role/local_developer/on_add()
	. = ..()
	
	for(var/path in typesof(/datum/permission))
		var/datum/permission/type = path // Not an instance of /datum/permission, this lets us introspect the initial value for a type
		if (initial(type.name) == null)
			continue

		var/datum/permission/perm = new path()
		src.user_client.add_permission(perm)
