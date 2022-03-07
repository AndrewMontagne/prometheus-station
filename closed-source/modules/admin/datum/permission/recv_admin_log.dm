/datum/permission/adminlog 
	name = "adminlog"

/// Do not call this directly, use the [LOG_ADMIN] define!
/proc/admin_log(var/ckey, var/msg)
	world.logger("([ckey]) [msg]", "ADMIN", "31")
	for (var/datum/permission/adminlog/P)
		if (P.client)
			P.client.stdout("<span style='color: red'>ADMIN LOG ([ckey]): [msg]</span>")
