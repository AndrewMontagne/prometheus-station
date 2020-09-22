/datum/permission/ban 
	name = "Banning"

/datum/permission/ban/on_add()
	src.assigned_client << "You can ban!"

/datum/permission/ban/on_remove()
	src.assigned_client << "You can no longer ban!"
