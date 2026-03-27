extends Node

var events_manager := EventManager.new()

# Constants
var _events: Array = load("res://const_data/events.tres").events
var EVENTS: Array:
	get: return _events

func game_start():
	for i in range(10):
		events_manager.push_event_random_place(EVENTS.pick_random())

	events_manager.push_event_front(EVENTS[Event.EventId.START_EVENT])
	events_manager.pop_back_to_current()
