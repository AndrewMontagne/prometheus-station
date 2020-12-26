/**
Admin Role
**/
/datum/role/admin
	priority = 100
	role_name = "Admin"

/datum/role/admin/is_client_eligible(client/user_client)
	return FALSE
