/datum/permission/debug 
	name = "Debugging"
	verbs = list(/client/proc/debug_variables,/client/proc/call_proc,/client/proc/toggle_profile)


/client/proc/toggle_profile()
	var/global/currently_profiling = FALSE

	if (!src.has_permission("DEBUG"))
		LOG_ADMIN(src.ckey, "[usr.ckey] tried to use the profiler without the debug permission!")
		src.stdout("You don't have permission to do this")
		return

	if (currently_profiling == FALSE)
		if(alert("Would you like to start a profiling session?","Profiler", "Yes", "No") == "Yes")
			LOG_ADMIN(src.ckey, "[usr.ckey] has started a profiling session!")
			world.Profile(PROFILE_START | PROFILE_AVERAGE, "json")
			currently_profiling = TRUE
	else
		LOG_ADMIN(src.ckey, "[usr.ckey] has finished a profiling session!")
		var/json_str = world.Profile(PROFILE_STOP | PROFILE_AVERAGE, "json")
		var/filename = "/tmp/profile_[time2text(world.timeofday,"YYYY-MM-DD_hh-mm-ss",0)].json"
		text2file(json_str, filename)
		var/json_file = file(filename)
		src << ftp(json_file, filename)
		currently_profiling = FALSE
		world.Profile(PROFILE_CLEAR)
		
