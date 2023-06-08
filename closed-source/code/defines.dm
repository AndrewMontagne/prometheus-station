/// Defines a global variable
#define VAR_GLOBAL(X)				/datum/globals/var/X
/// Defines a static variable
#define VAR_STATIC(X)				var/global/X

/// Log an error at the Error logging level
#define LOG_ERROR(X)				world.logger(X, "ERROR", "31")
/// Log an error at the Warning logging level
#define LOG_WARNING(X)				world.logger(X, "WARNI", "33")
/// Log an error at the System logging level
#define LOG_SYSTEM(X)				world.logger(X, "SYSTM", "32")
/// Log an error at the Information logging level
#define LOG_INFO(X)					world.logger(X, "INFOR", "34")
/// Log an error at the Debug logging level
#define LOG_DEBUG(X)				world.logger(X, "DEBUG", "35")
/// Log an error at the Trace logging level
#ifndef ENV_BUILD_RELEASE
#define LOG_TRACE(X)				world.logger(X, "TRACE", "36")
#else
#define LOG_TRACE(X)				// NO OP
#endif
/// Log an error at the Error logging level
#define LOG_ADMIN(C,X)				admin_log(C,X)

#define TRACE						"[__FILE__]:[__LINE__]"

#define FRAMES_PER_SECOND			10
/// Seconds to ticks
#define SECONDS(X)					(X * FRAMES_PER_SECOND)
/// Minutes to ticks
#define MINUTES(X)					(X * 600)
/// Hours to ticks
#define HOURS(X)					(X * 36000)

/// A list of all cardinal directions
#define ALL_DIRS					list(NORTH, NORTHEAST, EAST, SOUTHEAST, SOUTH, SOUTHWEST, WEST, NORTHWEST)

/// Realtime task priority
#define PRIORITY_REALTIME			1
/// High task priority
#define PRIORITY_HIGH				2
/// Medium task priority
#define PRIORITY_MEDIUM				3
/// Low task priority
#define PRIORITY_LOW				4

/**
Visibility Defines
**/

#define VISIBLITY_ALWAYS			0
#define VISIBLITY_UNDER_TILE		1
#define VISIBLITY_SUPER				100
#define VISIBLITY_NEVER				101

/**
These are the custom defined planes
**/

#define PLANE_SPACE					-55
#define PLANE_PARALLAX				-50
#define PLANE_GAME					-10
#define PLANE_DARKNESS				100
#define PLANE_SCREEN				999

/**
These are layer definitions
**/
#define LAYER_AREA					1
#define LAYER_TURF					2
#define LAYER_FLOOR					2.1
#define LAYER_OBJ					3
#define LAYER_MOB					4
#define LAYER_CEIL					4.9
#define LAYER_FLY					5

/**
These are defines for screen anchors
**/
#define ANCHOR_LEFT					"LEFT"
#define ANCHOR_RIGHT				"RIGHT"
#define ANCHOR_CENTER				"CENTER"
#define ANCHOR_TOP					"TOP"
#define ANCHOR_BOTTOM				"BOTTOM"

/**
These are the canonical names for inventory slots, 
so that they can be used for sprites.
**/

#define SLOT_ID						"id_card"
#define SLOT_GLOVES					"gloves"
#define SLOT_GLASSES				"glasses"
#define SLOT_EARS					"ears"
#define SLOT_MASK					"mask"
#define SLOT_SHIRT					"shirt"
#define SLOT_TROUSERS				"trousers"
#define SLOT_SHOES					"shoes"
#define SLOT_JACKET					"jacket"
#define SLOT_SUIT					"suit"
#define SLOT_HAT					"hat"
#define SLOT_BELT					"belt"
#define SLOT_BACK					"back"
#define SLOT_LEFT_HAND				"lefthand"
#define SLOT_RIGHT_HAND				"righthand"

#define SLOT_BELT_CLIP_R			"beltclip_r"
#define SLOT_BELT_CLIP_L			"beltclip_l"
#define SLOT_POCKET					"pocket"

/**
These are the canonical names for damage type
**/
#define DAMAGE_BRUTE				"brute"

/**
These are the kinds of tile smoothing
**/
#define SMOOTHING_NONE				0
#define SMOOTHING_ALL				1
#define SMOOTHING_TURFS				2
#define SMOOTHING_STRUCTS			3

#define SMOOTHING_DIR_N				1
#define SMOOTHING_DIR_E				2
#define SMOOTHING_DIR_S				4
#define SMOOTHING_DIR_W				8
#define SMOOTHING_DIR_NE			1
#define SMOOTHING_DIR_SE			2
#define SMOOTHING_DIR_SW			4
#define SMOOTHING_DIR_NW			8

/**
These define the types of tools
**/
#define TOOL_PROPER					1
#define TOOL_IMPROPER				2

#define TOOL_NONE					0
#define TOOL_SCREWDRIVER			1
#define TOOL_WRENCH					2
#define TOOL_CUTTERS				3
#define TOOL_WELDING				4
#define TOOL_CROWBAR				5
#define TOOL_MULTITOOL				6

/**
These define network stuff
**/
#define NET_OFFSET_LEFT				0
#define NET_OFFSET_MIDDLE			1
#define NET_OFFSET_RIGHT			2

#define NET_LAYER_PLATING			0
#define NET_LAYER_TILE				1

#define NET_KIND_UNDEFINED			0
#define NET_KIND_POWER				1
#define NET_KIND_DATA				2
#define NET_KIND_ATMOS				3
#define NET_KIND_BLOB				4

/**
Scientific Defines
**/

// Matter phase enum
#define PHASE_SOLID					"SOLID"
#define PHASE_LIQUID				"LIQUID"
#define PHASE_GAS					"GAS"

#define ALL_PHASES					list(PHASE_SOLID, PHASE_LIQUID, PHASE_GAS)

#define ATMOSCHEM_MOLES				1
#define ATMOSCHEM_TEMP				2

/**
* Okay so. There are 41.58 moles per cubic meter of dinitrogen at STP.
* Each tile is 2m * 2m * 2m, so 8m3, so each tile has about 332 moles.
* Each "face" of the tile has 4 square meters, if we set this to 20, each
* tile will try and exchange ~80 moles of gas per atmosphere.
*
* This means at STP, each cell should exchange more or less all its contents
* for the purposes of diffusion.
*
* Yes I tried calculating this realistically, it ended up bringing up papers
* on the enrichment of uranium isotopes in gas centrifuges.
*
* I am not looking again.
**/
#define GAS_EXCHANGE_CONST			20

#define IDEAL_GAS_CONSTANT			8.314462

// Mass
#define MILLIGRAMS(X)				(X / 10E6)
#define GRAMS(X)					(X / 10E3)
#define KILOGRAMS(X)				(X)
#define TONNES(X)					(X * 1000)
#define EARTH_MASS(X)				(X * 5.974 * 10E24)
#define SOLAR_MASS(X)				(X * 1.988 * 10E30)

// Temperature
#define CELSIUS(X)					(273.15 + X)
#define KELVINS(X)					(X)

// Pressure
#define ATM(X)						(X * 101325)
#define PA(X)						(X)
#define KPA(X)						(X * 10E3)
#define MPA(X)						(X * 10E6)

// Density
#define GS_PER_LITRE(X)				(X * 10E-3)
#define KGS_PER_LITRE(X)			(X)
#define KGS_PER_M3(X)				(X * 10E3)

// Length
#define MILLIMETRES(X)				(X * 10E-3)
#define CENTIMETRES(X)				(X * 10E-2)
#define METRES(X)					(X)
#define TILES(X)					(X * 2)
#define KILOMETERS(X)				(X * 10E3)
#define MEGAMETERS(X)				(X * 10E6)
#define ASTRONOMICAL_UNITS(X)		(X * 1.495 * 10E11)
#define LIGHT_YEAR(X)				(X * 9.361 * 10E15)

// Volume
#define MILLILITRES(X)				(X * 10E-3)
#define LITRES(X)					(X)
#define CUBIC_METRES(X)				(X * 10E3)
#define CUBIC_TILES(X)				(X * 8 * 10E3)

// Power
#define MILLIWATTS(X)				(X * 10E-3)
#define WATTS(X)					(X)
#define KILOWATTS(X)				(X * 10E3)
#define MEGAWATTS(X)				(X * 10E6)
#define GIGAWATTS(X)				(X * 10E9)

// Energy
#define JOULES(X)					(X)
#define KILOJOULES(X)				(X * 10E3)
#define MEGAJOULES(X)				(X * 10E6)
#define GIGAJOULES(X)				(X * 10E9)

/**
Atmoschem Defines
**/

#define ONE_L_PARTIAL_PRES_MOL		41.57
#define O2_1L_PARTIAL_PRES_MOL		(ONE_L_PARTIAL_PRES_MOL * 0.22)
#define N2_1L_PARTIAL_PRES_MOL		(ONE_L_PARTIAL_PRES_MOL * 0.78)
#define DEFAULT_GAS_MIX				list(PHASE_GAS = list(\
	"o2" = list(O2_1L_PARTIAL_PRES_MOL * CUBIC_TILES(1), CELSIUS(20)), \
	"n2" = list(N2_1L_PARTIAL_PRES_MOL * CUBIC_TILES(1), CELSIUS(20)) \
))
