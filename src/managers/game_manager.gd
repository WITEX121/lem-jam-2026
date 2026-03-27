extends Node

signal new_answers_ready(answers: Array[ReplyElement])
signal prompt_finished()
signal reply_selected()

var cursor_arrow = preload("res://assets/icons/pointer_a.png")
var cursor_button = preload("res://assets/icons/hand_point.png")

var events_manager := EventManager.new()
var replies_manager := ReplyManager.new()

var ratings := Ratings.new(50, 50, 50, 50)

# Constants
var _events: Array = load("res://const_data/events/events.tres").events
var EVENTS: Array:
	get: return _events

func game_start():
	events_manager.push_event(EVENTS[PromptEvent.EventId.START])
	events_manager.pop_back_to_current()
