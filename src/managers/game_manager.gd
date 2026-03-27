extends Node

var cursor_arrow = preload("res://assets/icons/pointer_a.png")
var cursor_button = preload("res://assets/icons/hand_point.png")

var events_manager := EventManager.new()
var replies_manager := ReplyManager.new()

# test only
var selected: int = 0

var ratings := Ratings.new(50, 50, 50, 50)

# Constants
var _events := Parser.load_events()
var EVENTS:
	get: return _events

func game_start():
	for i in range(5):
		events_manager.push_event(GameManager.EVENTS["NO_EVENTS"])
	events_manager.push_event(GameManager.EVENTS["PAPIER_DO_KIBLA"], PromptEvent.PushType.NEXT1)
	events_manager.pop_back_to_current()
