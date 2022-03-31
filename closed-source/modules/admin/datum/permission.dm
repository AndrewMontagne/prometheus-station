//! Class to encapsulate specific permissions
/datum/permission
	var/name = null
	var/client/client = null
	var/list/verbs = list()

//! Utility method to allow for additional verification logic
/datum/permission/proc/verify()
	return TRUE

//! Associative array of permissions
/client
	VAR_PRIVATE/list/permissions = list()
	VAR_STATIC(list/permissions_to_clients) = list()

//! Adds a permission to a client
/client/proc/add_permission(datum/permission/perm)
	SHOULD_NOT_OVERRIDE(TRUE)
	var/permkey = perm.get_permission_key()
	src.permissions[permkey] = perm
	perm.client = src
	perm.on_client_add()
	if(!islist(src.permissions_to_clients[permkey]))
		src.permissions_to_clients[permkey] = list()
	src.permissions_to_clients[permkey] |= src

//! Removes 
/client/proc/remove_permission(permkey)
	SHOULD_NOT_OVERRIDE(TRUE)
	var/datum/permission/perm = src.permissions[permkey]
	src.permissions[permkey] = null
	src.permissions_to_clients.Remove(src)
	perm.on_client_remove()
	perm.client = null
	perm.Del()

/datum/permission/proc/get_permission_key()
	return uppertext(copytext("[src.type]", 19))

//! Called when a client has this permission added
/datum/permission/proc/on_client_add()
	src.client.verbs |= src.verbs

//! Called when a client has this permission removed
/datum/permission/proc/on_client_remove()
	src.client.verbs -= src.verbs

//! Checks if a client has a permission, and that it is valid
/client/proc/has_permission(permission_name)
	SHOULD_NOT_OVERRIDE(TRUE)
	var/datum/permission/perm = src.permissions[permission_name]
	if(isnull(perm))
		return FALSE
	else
		return perm.verify()

//! Checks if a mob's client has a permission, and that it is valid
/mob/proc/has_permission(permission_name)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(src.client)
		return src.client.has_permission(permission_name)
	return FALSE
