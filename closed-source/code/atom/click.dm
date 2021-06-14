
/atom/proc/HarmClick(mob/source, list/params)
	return src.HelpClick(source, params)
/atom/proc/DisarmClick(mob/source, list/params)
	return src.HelpClick(source, params)
/atom/proc/GrabClick(mob/source, list/params)
	return src.HelpClick(source, params)
/atom/proc/HelpClick(mob/source, list/params)
	return TRUE
	
/atom/proc/HarmDoubleClick(mob/source, list/params)
	return src.HarmClick(source, params)
/atom/proc/DisarmDoubleClick(mob/source, list/params)
	return src.DisarmClick(source, params)
/atom/proc/GrabDoubleClick(mob/source, list/params)
	return src.GrabClick(source, params)
/atom/proc/HelpDoubleClick(mob/source, list/params)
	return src.HelpClick(source, params)
