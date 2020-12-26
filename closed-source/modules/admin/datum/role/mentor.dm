/**
Mentor Role
**/
/datum/role/mentor
	priority = 300
	role_name = "Mentor"

/datum/role/mentor/is_client_eligible(client/user_client)
	return TRUE
