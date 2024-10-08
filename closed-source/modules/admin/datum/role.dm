/**
Role Base Class

Determines what `/datum/permission`s a user has. A user can only have one role.
**/
/datum/role
	VAR_PROTECTED/client/client /// The client this who has this role
	var/priority = 0 /// The priority in which this role will be picked, lower is picked first.
	var/role_name = null /// The name of the role. Must be set in order to be a candidate
	VAR_PROTECTED/permissions = list() /// The list of the permissions this role has

/// Returns whether a client is eligible for this role
/datum/role/proc/is_client_eligible(client/user_client)
	throw EXCEPTION("No implementation")

/// Performs any logic that needs to be done when a client recieves a role.
/datum/role/proc/on_client_add(client/new_client)
	SHOULD_CALL_PARENT(TRUE)
	src.client = new_client

/// Performs any logic that needs to be done when a client recieves a role.
/datum/role/proc/on_client_remove()
	SHOULD_CALL_PARENT(TRUE)
	src.client = null

/// Performs any logic that needs to be done when a mob recieves a role.
/datum/role/proc/on_mob_add(client/new_client)
	SHOULD_CALL_PARENT(TRUE)
	src.client = new_client

/// Performs any logic that needs to be done when a mob recieves a role.
/datum/role/proc/on_mob_remove()
	SHOULD_CALL_PARENT(TRUE)
	src.client = null

/datum/role/proc/get_role_key()
	return copytext("[src.type]", 13)

VAR_GLOBAL(list/client/roles_to_clients) = list()

/client
	VAR_PRIVATE/datum/role/role = null

/client/proc/give_role(datum/role/new_role)
	if (!isnull(src.role))
		src.remove_role()
	src.role = new_role
	src.role.on_client_add(src)
	var/rolekey = src.role.get_role_key()
	if(!islist(GLOBALS.roles_to_clients[rolekey]))
		GLOBALS.roles_to_clients[rolekey] = list()
	GLOBALS.roles_to_clients[rolekey] |= src

/client/proc/remove_role()
	GLOBALS.roles_to_clients.Remove(src)
	src.role.on_client_remove()
	spawn(0) src.role.Del()
	src.role = null

/// Append to the client constructor some logic to assign a role to them where possible
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
			src.give_role(role)
			break

	return .
