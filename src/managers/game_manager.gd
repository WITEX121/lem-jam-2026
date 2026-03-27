extends Node

var events_manager := EventManager.new()

var ratings := Ratings.new(50, 50, 50, 50)

# Constants
var _events: Array = load("res://const_data/events/events.tres").events
var EVENTS: Array:
	get: return _events

func game_start():
	events_manager.push_event(EVENTS[PromptEvent.EventId.START])
	events_manager.pop_back_to_current()
