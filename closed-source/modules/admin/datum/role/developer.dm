/**
Developer Role
**/
/datum/role/dev
	priority = 200
	role_name = "Dev"

/datum/role/dev/is_client_eligible(client/user_client)
	return TRUE
