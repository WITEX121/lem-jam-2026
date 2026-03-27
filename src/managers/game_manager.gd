extends Node

enum finish_scenarios {
	NOT_FINISHED,
	NO_EMPLOYEES,
	LOST_TRUST,
	TOP_TRUST,
}

var cursor_arrow = preload("res://assets/icons/pointer_a.png")
var cursor_button = preload("res://assets/icons/hand_point.png")

# test only
var selected: int = 0

var ratings := Ratings.new(50, 50, 50, 50)
var employee_count: int = 10
var finish_scenario := finish_scenarios.NOT_FINISHED

# Constants
var _events := Parser.load_events()
var EVENTS:
	get: return _events

func game_start():
	for i in range(5):
		EventManager.push_event(GameManager.EVENTS["NO_EVENTS"])
	EventManager.push_event(GameManager.EVENTS["PAPIER_DO_KIBLA"], PromptEvent.PushType.NEXT1)
	EventManager.pop_back_to_current()
