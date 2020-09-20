//! The user role datum. This determines the permissions a user has.
/datum/role
	VAR_PROTECTED/client/assigned_client //! The client this who has this role
	var/priority = 0 //! The priority in which this role will be picked, lower is picked first.
	var/role_name = null //! The name of the role. Must be set in order to be a candidate

//! Returns whether a client is eligible for this role
/datum/role/proc/is_client_eligible(client/user_client)
	throw EXCEPTION("No implementation")

//! Performs any logic that needs to be done when a client recieves a role.
/datum/role/proc/apply_to_client(client/user_client)
	throw EXCEPTION("No implementation")

/client/var/role = null

// Append to the client constructor some logic to assign a role to them where possible
/client/New()
	. = ..()

	var/list/potential_roles = list()

	for(var/path in typesof(/datum/role))
		var/datum/role/type = path // Not an instance of /datum/role, this lets us introspect the initial value for a type
		if (initial(type.role_name) == null)
			continue
		potential_roles += new path()

	potential_roles = list_bubblesort(potential_roles, "priority")

	for(var/datum/role/role in potential_roles)
		if(role.is_client_eligible(src))
			src.role = role
			role.apply_to_client(src)
			break

	return .
