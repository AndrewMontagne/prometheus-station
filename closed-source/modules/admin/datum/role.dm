//! The user role datum. This determines the permissions a user has.
/datum/role
	var/client/assigned_client //! The client this who has this role
	var/list/permissions //! The permission this role has
	var/priority = -1 //! The priority in which this role will be picked, lower is picked first. priority of -1 won"t be attempted.
	var/role_name = "Blank Role"

//! Returns whether a client is eligible for this role
/datum/role/proc/is_client_eligible(client/user_client)
	throw EXCEPTION("No implementation")

//! Performs any logic that needs to be done when a client recieves a role.
/datum/role/proc/apply_to_client(client/user_client)
	user_client << "\blue You have been authenticated as a [src.role_name]"

/client/var/role = null

// Append to the client constructor some logic to assign a role to them where possible
/client/New()
	. = ..()

	var/list/potential_roles = list()

	for(var/path in typesof(/datum/role))
		var/datum/role/type = path // Not an instance of /datum/role, this lets us introspect the initial value for a type
		if (initial(type.priority) == -1)
			continue
		potential_roles += new path()

	potential_roles = list_bubblesort(potential_roles, "priority")

	for(var/datum/role/role in potential_roles)
		if(role.is_client_eligible(src))
			src.role = role
			role.apply_to_client(src)
			break

	return .
