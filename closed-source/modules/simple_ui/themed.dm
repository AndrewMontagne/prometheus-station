/datum/simple_ui/themed
	var/datum/asset/sui_theme/theme = null
	var/content_root = ""
	var/current_page = "index.html"
	var/root_template = ""
	VAR_STATIC(var/list/sui_file_cache)

/datum/simple_ui/themed/New(atom/n_datasource, n_width = 512, n_height = 512, n_content_root = "")
	if (src.sui_file_cache == null)
		src.sui_file_cache = list()
	src.theme = src.get_theme()
	src.root_template = src.get_themed_file("index.html")
	src.content_root = n_content_root
	return ..(n_datasource, n_width, n_height, src.theme)

/datum/simple_ui/themed/proc/get_theme()
	return null

/datum/simple_ui/themed/process()
	if(auto_check_view)
		check_view_all()
	if(auto_refresh)
		soft_update_fields()

VAR_GLOBAL(list/sui_template_variables)

/datum/simple_ui/themed/proc/get_file(path)
	if(path in src.sui_file_cache)
		return src.sui_file_cache[path]
	else if(fexists(path))
		var/data = file2text(path)
		src.sui_file_cache[path] = data
		return data
	else
		var/errormsg = "SIMPLE_UI MISSING PATH '[path]'"
		LOG_ERROR(errormsg)
		return errormsg

/datum/simple_ui/themed/proc/get_content_file(filename)
	return get_file("assets/mit/simple_ui/content/[content_root]/[filename]")

/datum/simple_ui/themed/proc/get_themed_file(filename)
	return get_file("[theme.theme_root]/[filename]")

/datum/simple_ui/themed/proc/process_template(template, variables)
	var/regex/pattern = regex("\\@\\{(\\w+)\\}","gi")
	GLOBALS.sui_template_variables = variables
	var/replaced = pattern.Replace(template, /proc/sui_process_template_replace)
	GLOBALS.sui_template_variables = null
	return replaced

/proc/sui_process_template_replace(match, group1)
	var/value = GLOBALS.sui_template_variables[group1]
	return "[value]"

/datum/simple_ui/themed/proc/get_inner_content(mob/target)
	var/list/data = call(datasource, "sui_data")(target)
	return src.process_template(get_content_file(current_page), data)

/datum/simple_ui/themed/get_content(mob/target)
	var/list/template_data = list("title" = datasource.name, "body" = get_inner_content(target))
	return src.process_template(root_template, template_data)

/datum/simple_ui/themed/proc/soft_update_fields()
	for(var/viewer in viewers)
		var/json = json_encode(call(datasource, "sui_data")(viewer))
		call_js(viewer, "updateFields", list(json))

/datum/simple_ui/themed/proc/soft_update_all()
	for(var/viewer in viewers)
		call_js(viewer, "replaceContent", list(get_inner_content(viewer)))

/datum/simple_ui/themed/proc/change_page(var/newpage)
	if(newpage == current_page)
		return
	current_page = newpage
	render_all()

/datum/simple_ui/themed/proc/act(label, mob/user, action, list/parameters = list(), class = "", disabled = FALSE)
	if(disabled)
		return "<a class=\"disabled\">[label]</a>"
	else
		return "<a class=\"[class]\" href=\"" + href(user, action, parameters) + "\">[label]</a>"

/datum/simple_ui/themed/paper

/datum/simple_ui/themed/nano

/datum/simple_ui/themed/get_theme()
	return new /datum/asset/sui_theme/nano()
	
