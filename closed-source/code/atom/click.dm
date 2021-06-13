
/atom/proc/OnShiftMiddleClick(mob/source, list/params)
	return src.OnMiddleClick(source, params)
/atom/proc/OnCtrlMiddleClick(mob/source, list/params)
	return src.OnMiddleClick(source, params)
/atom/proc/OnCtrlShiftMiddleClick(mob/source, list/params)
	return src.OnMiddleClick(source, params)
/atom/proc/OnMiddleClick(mob/source, list/params)
	return TRUE

/atom/proc/OnCtrlShiftClick(mob/source, list/params)
	return src.OnClick(source, params)
/atom/proc/OnShiftClick(mob/source, list/params)
	return src.OnClick(source, params)
/atom/proc/OnAltClick(mob/source, list/params)
	return src.OnClick(source, params)
/atom/proc/OnCtrlClick(mob/source, list/params)
	return src.OnClick(source, params)
/atom/proc/OnClick(mob/source, list/params)
	return TRUE
	
/atom/proc/OnCtrlShiftDoubleClick(mob/source, list/params)
	return src.OnDoubleClick(source, params)
/atom/proc/OnShiftDoubleClick(mob/source, list/params)
	return src.OnDoubleClick(source, params)
/atom/proc/OnAltDoubleClick(mob/source, list/params)
	return src.OnDoubleClick(source, params)
/atom/proc/OnCtrlDoubleClick(mob/source, list/params)
	return src.OnDoubleClick(source, params)
/atom/proc/OnDoubleClick(mob/source, list/params)
	return TRUE
