/datum/permission/adminlog 
	name = "adminlog"

/proc/admin_log(var/msg)
	world.logger(msg, "ADMIN", "31")
	for (var/datum/permission/adminlog/P)
		if (P.client)
			P.client << "<span style='color: red'>ADMIN LOG: [msg]</span>"
