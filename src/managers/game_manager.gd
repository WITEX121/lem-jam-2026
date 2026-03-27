extends Node

var events_manager := EventManager.new()

# Constants
var _events: Array = load("res://const_data/events.tres").events
var EVENTS: Array:
	get: return _events

func game_start():
	events_manager.push_event_front(EVENTS[Event.EventId.START_EVENT])
	events_manager.pop_back_to_current()
