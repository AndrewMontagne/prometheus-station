/client/var/downloaded_assets = list()

/datum/asset
	var/list/assets = list()

/datum/asset/proc/asset_key()
	return "[src.type]"

/datum/asset/proc/send(mob/target)
	if (!target.client)
		return

	if (src.asset_key() in target.client.downloaded_assets)
		return

	for (var/asset in src.assets)
		target.client << browse_rsc(src.assets[asset], asset)

	target.client.downloaded_assets += src.asset_key()

/datum/asset/sui_theme
	var/theme_root = null

/datum/asset/sui_theme/nano
	theme_root = "assets/mit/simple_ui/themes/nano"
	assets = list(
		// JavaScript
		"sui-nano-common.js"		= 'assets/mit/simple_ui/themes/nano/sui-nano-common.js',
		"sui-nano-jquery.min.js"	= 'assets/mit/simple_ui/themes/nano/sui-nano-jquery.min.js',
		// Stylesheets
		"sui-nano-common.css"		= 'assets/mit/simple_ui/themes/nano/sui-nano-common.css',
	)

/datum/asset/sui_theme/sui_theme_paper
	theme_root = "assets/mit/simple_ui/themes/paper"
	assets = list(
		// JavaScript
		"sui-paper-common.js"		= 'assets/mit/simple_ui/themes/paper/sui-paper-common.js',
		// Stylesheets
		"sui-paper-common.css"		= 'assets/mit/simple_ui/themes/paper/sui-paper-common.css',
		// Images
		"curl-left.png"				= 'assets/mit/simple_ui/themes/paper/curl-left.png',
		"curl-right.png"			= 'assets/mit/simple_ui/themes/paper/curl-right.png',
	)
