/// Defines a global variable
#define VAR_GLOBAL(X) /datum/globals/var/X
/// Defines a static variable
#define VAR_STATIC(X) var/global/X

/// Log an error at the Error logging level
#define LOG_ERROR(X)   world.logger(X, "ERROR", "31")
/// Log an error at the Warning logging level
#define LOG_WARNING(X) world.logger(X, "WARNI", "33")
/// Log an error at the System logging level
#define LOG_SYSTEM(X)  world.logger(X, "SYSTM", "32")
/// Log an error at the Information logging level
#define LOG_INFO(X)    world.logger(X, "INFOR", "34")
/// Log an error at the Debug logging level
#define LOG_DEBUG(X)   world.logger(X, "DEBUG", "35")
/// Log an error at the Trace logging level
#ifndef ENV_BUILD_RELEASE
#define LOG_TRACE(X)   world.logger(X, "TRACE", "36")
#else
#define LOG_TRACE(X)   // NO OP
#endif
/// Log an error at the Error logging level
#define LOG_ADMIN(C,X)   admin_log(C,X)

#define TRACE "[__FILE__]:[__LINE__]"

/// Seconds to ticks
#define SECONDS(X) (X * 10)
/// Minutes to ticks
#define MINUTES(X) (X * 600)
/// Hours to ticks
#define HOURS(X) (X * 36000)

/// A list of all cardinal directions
#define ALL_DIRS list(NORTH, NORTHEAST, EAST, SOUTHEAST, SOUTH, SOUTHWEST, WEST, NORTHWEST)
#define INVERT_DIR_MAP list("0" = 0, "[NORTH]" = SOUTH, "[SOUTH]" = NORTH, "[EAST]" = WEST, "[WEST]" = EAST)  

/// Realtime task priority
#define PRIORITY_REALTIME 1
/// High task priority
#define PRIORITY_HIGH 2
/// Medium task priority
#define PRIORITY_MEDIUM 3
/// Low task priority
#define PRIORITY_LOW 4

/**
Visibility Defines
**/

#define VISIBLITY_ALWAYS      0
#define VISIBLITY_UNDER_TILE  1
#define VISIBLITY_SUPER       100
#define VISIBLITY_NEVER       101

/**
These are the custom defined planes
**/

#define PLANE_SPACE -55
#define PLANE_PARALLAX -50
#define PLANE_GAME -10
#define PLANE_DARKNESS 100
#define PLANE_SCREEN 999

/**
These are layer definitions
**/
#define LAYER_AREA   1
#define LAYER_TURF   2
#define LAYER_FLOOR  2.1
#define LAYER_OBJ    3
#define LAYER_MOB    4
#define LAYER_CEIL   4.9
#define LAYER_FLY    5

/**
These are defines for screen anchors
**/
#define ANCHOR_LEFT			"LEFT"
#define ANCHOR_RIGHT		"RIGHT"
#define ANCHOR_CENTER		"CENTER"
#define ANCHOR_TOP			"TOP"
#define ANCHOR_BOTTOM		"BOTTOM"

/**
Multi-z defines
**/

#define MULTI_Z_START 2
#define MULTI_Z_END   4

/**
These are the canonical names for inventory slots, so that they can be used for sprites.
**/

#define SLOT_ID				"id_card"
#define SLOT_GLOVES			"gloves"
#define SLOT_GLASSES		"glasses"
#define SLOT_EARS			"ears"
#define SLOT_MASK			"mask"
#define SLOT_SHIRT			"shirt"
#define SLOT_TROUSERS		"trousers"
#define SLOT_SHOES			"shoes"
#define SLOT_JACKET			"jacket"
#define SLOT_SUIT			"suit"
#define SLOT_HAT			"hat"
#define SLOT_BELT			"belt"
#define SLOT_BACK			"back"
#define SLOT_LEFT_HAND		"lefthand"
#define SLOT_RIGHT_HAND		"righthand"

#define SLOT_BELT_CLIP_R	"beltclip_r"
#define SLOT_BELT_CLIP_L	"beltclip_l"
#define SLOT_POCKET			"pocket"

/**
These are the canonical names for damage type
**/
#define DAMAGE_BRUTE	"brute"

/**
These are the kinds of tile smoothing
**/
#define SMOOTHING_NONE		0
#define SMOOTHING_ALL		1
#define SMOOTHING_TURFS		2
#define SMOOTHING_STRUCTS	3

#define SMOOTHING_DIR_N		1
#define SMOOTHING_DIR_E		2
#define SMOOTHING_DIR_S		4
#define SMOOTHING_DIR_W		8
#define SMOOTHING_DIR_NE	1
#define SMOOTHING_DIR_SE	2
#define SMOOTHING_DIR_SW	4
#define SMOOTHING_DIR_NW	8

/**
These define the types of tools
**/
#define TOOL_PROPER			1
#define TOOL_IMPROPER		2

#define TOOL_NONE			0
#define TOOL_SCREWDRIVER	1
#define TOOL_WRENCH			2
#define	TOOL_CUTTERS		3
#define TOOL_WELDING		4
#define TOOL_CROWBAR		5
#define TOOL_MULTITOOL		6

/**
These define network stuff
**/
#define NET_OFFSET_LEFT 	0
#define NET_OFFSET_MIDDLE 	1
#define NET_OFFSET_RIGHT 	2

#define NET_LAYER_PLATING	0
#define NET_LAYER_TILE		1

#define NET_KIND_UNDEFINED 	0
#define NET_KIND_POWER		1
#define NET_KIND_DATA		2
#define NET_KIND_ATMOS		3
#define NET_KIND_BLOB		4

/**
Power Defines
**/
#define WATTS(X) 			(X)
#define KILOWATTS(X) 		(X * 1000)
#define MEGAWATTS(X) 		(X * 1000000)
#define GIGAWATTS(X) 		(X * 1000000000)

#define JOULES(X) (X)
#define KILOJOULES(X) 		(X * 1000)
#define MEGAJOULES(X) 		(X * 1000000)
#define GIGAJOULES(X) 		(X * 1000000000)
