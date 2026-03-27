extends Node

var events_manager := EventManager.new()
var replies_manager := ReplyManager.new()

var ratings := Ratings.new(50, 50, 50, 50)

# Constants
var _events: Array = load("res://const_data/events.tres").events
var EVENTS: Array:
	get: return _events

func game_start():
	var events = []
	for i in range(10):
		events.push_back(EVENTS.pick_random())
	events_manager.unlock_events(events)

	events_manager.push_event_front(EVENTS[Event.EventId.START_EVENT])
	events_manager.pop_back_to_current()
