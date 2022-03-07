
var/global/list/global_event_listeners = list()

/datum
	var/list/subscribed_events = list()

/**
Sends an event to all listeners, if `broadcast` is FALSE, the event will stop
being propagated as soon as a listener returns TRUE.

returns whether the event was processed by a listener
**/
/datum/proc/send_event(var/event_name, var/payload, var/broadcast = TRUE)
	var/handled = FALSE
	if (global_event_listeners.Find(event_name) == 0)
		return FALSE
	for (var/datum/D in global_event_listeners[event_name])
		var/ret = D.recieve_event(origin=src, event_name=event_name, payload=payload)
		handled |= ret
		if (ret && broadcast)
			return handled
	return handled

/**
Called when an event is recieved. Default implementation tries to call a function called `recv_[event_name]`
**/
/datum/proc/recieve_event(var/datum/origin, var/event_name, var/payload)
	return call(src, "recv_[event_name]")(payload)

/**
Subscribes to an event topic.
**/
/datum/proc/subscribe_to_events(var/event_name)
	if (src.subscribed_events.Find(event_name) == 0)
		src.subscribed_events[event_name] = list(src)
	else
		src.subscribed_events[event_name]:Add(src)

	if (global_event_listeners.Find(event_name) == 0)
		global_event_listeners[event_name] = list(src)
	else
		global_event_listeners[event_name]:Add(src)

/// Unsubscribes from an event topic.
/datum/proc/unsubscribe_from_events(var/event_name)
	src.subscribed_events[event_name]:Remove(src)
	global_event_listeners[event_name]:Remove(src)

/datum/Del()
	. = ..()
	for (var/event_name in src.subscribed_events)
		for (var/datum/origin in src.subscribed_events[event_name])
			src.unsubscribe_from_events(origin, event_name)
