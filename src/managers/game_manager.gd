extends Node

var cursor_arrow = preload("res://assets/icons/pointer_a.png")
var cursor_button = preload("res://assets/icons/hand_point.png")

var events_manager := EventManager.new()
var replies_manager := ReplyManager.new()

var ratings := Ratings.new(50, 50, 50, 50)

# Constants
var _events := EventParser.load_events()
var EVENTS:
	get: return _events

func game_start():
	events_manager.push_event(GameManager.EVENTS["PAPIER_DO_KIBLA"])
	events_manager.pop_back_to_current()
