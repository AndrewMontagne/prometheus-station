//! Class to encapsulate specific permissions
/datum/permission
	var/name = null
	var/client/assigned_client = null

//! Utility method to allow for additional verification logic
/datum/permission/proc/verify()
	return TRUE

//! Associative array of permissions
/client/var/list/permissions = list()

//! Adds a permission to a client
/datum/permission/proc/assign_to_client(client/candidate)
	var/permission_key = copytext("[src.type]", 19)
	candidate.permissions[permission_key] = src
	src.assigned_client = candidate
	candidate << "\red You have been given the [permission_key] permission!"

//! Checks if a client has a permission, and that it is valid
/client/proc/has_permission(permission_name)
	var/datum/permission/perm = src.permissions[permission_name]
	return perm != null

//! Checks if a mob's client has a permission, and that it is valid
/mob/proc/has_permission(permission_name)
	if(src.client)
		return src.client.has_permission(permission_name)
	return FALSE
