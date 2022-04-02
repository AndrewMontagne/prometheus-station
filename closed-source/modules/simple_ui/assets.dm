/datum/sui_theme
	var/list/assets = list()

/datum/sui_theme/proc/send(mob/target)
	//NOOP, for now

/datum/sui_theme/nano
	assets = list(
		// JavaScript
		"sui-nano-common.js"		= 'assets/mit/simple_ui/themes/nano/sui-nano-common.js',
		"sui-nano-jquery.min.js"	= 'assets/mit/simple_ui/themes/nano/sui-nano-jquery.min.js',
		// Stylesheets
		"sui-nano-common.css"		= 'assets/mit/simple_ui/themes/nano/sui-nano-common.css',
	)

/datum/sui_theme/sui_theme_paper
	assets = list(
		// JavaScript
		"sui-paper-common.js"		= 'assets/mit/simple_ui/themes/paper/sui-paper-common.js',
		// Stylesheets
		"sui-paper-common.css"		= 'assets/mit/simple_ui/themes/paper/sui-paper-common.css',
		// Images
		"curl-left.png"				= 'assets/mit/simple_ui/themes/paper/curl-left.png',
		"curl-right.png"			= 'assets/mit/simple_ui/themes/paper/curl-right.png',
	)
