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
#define LOG_TRACE(X)   world.logger(X, "TRACE", "36")

/// Seconds to ticks
#define SECONDS(X) (X * 10)
/// Minutes to ticks
#define MINUTES(X) (X * 600)
/// Hours to ticks
#define HOURS(X) (X * 36000)

/// A list of all cardinal directions
#define ALL_DIRS list(NORTH, SOUTH, EAST, WEST)

/// Realtime task priority
#define PRIORITY_REALTIME 1
/// High task priority
#define PRIORITY_HIGH 2
/// Medium task priority
#define PRIORITY_MEDIUM 3
/// Low task priority
#define PRIORITY_LOW 4
