#define LOG_ERROR(X)   world.logger(X, "ERROR", "31")
#define LOG_WARNING(X) world.logger(X, "WARNI", "33")
#define LOG_SYSTEM(X)  world.logger(X, "SYSTM", "32")
#define LOG_INFO(X)    world.logger(X, "INFOR", "34")
#define LOG_DEBUG(X)   world.logger(X, "DEBUG", "35")
#define LOG_TRACE(X)   world.logger(X, "TRACE", "36")

#define ALL_DIRS list(NORTH, SOUTH, EAST, WEST)

#define PRIORITY_REALTIME 1
#define PRIORITY_HIGH 2
#define PRIORITY_MEDIUM 3
#define PRIORITY_LOW 4
