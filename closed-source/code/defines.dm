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
#define LOG_ADMIN(X)   admin_log(X)

#define TRACE "[__FILE__]:[__LINE__]"

/// Seconds to ticks
#define SECONDS(X) (X * 10)
/// Minutes to ticks
#define MINUTES(X) (X * 600)
/// Hours to ticks
#define HOURS(X) (X * 36000)

/// A list of all cardinal directions
#define ALL_DIRS list(NORTH, SOUTH, EAST, WEST)
#define MIDDLE -1 // Not a real direction, for the toolbar system

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

#define ALWAYS_INVISIBLE 101

/**
These are the custom defined planes
**/

#define PLANE_SPACE -55
#define PLANE_PARALLAX -50
#define PLANE_GAME -10
#define PLANE_DARKNESS 100
#define PLANE_SCREEN 999

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
