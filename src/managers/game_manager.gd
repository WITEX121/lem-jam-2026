extends Node

signal next_question
signal new_question(question: String)
signal start_answer()
signal answer_provided(answer: String)
signal employee_count_changed(employee_count: int)

enum finish_scenarios {
	NOT_FINISHED,
	NO_EMPLOYEES,
	LOST_TRUST,
	TOP_TRUST,
}


var pracownik_wyjebaned_efekt_scene: PackedScene = preload("res://src/pracownik_wyjebaaaned.tscn")
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

func _ready():
	employee_count_changed.connect(_on_employee_count_changed)

func _on_employee_count_changed(_count: int):
	var pracownik_wyjebaned = pracownik_wyjebaned_efekt_scene.instantiate()
	add_child(pracownik_wyjebaned)

func game_start():
	for i in range(5):
		EventManager.push_event(GameManager.EVENTS["NO_EVENTS"])
	EventManager.push_event(GameManager.EVENTS["PAPIER_DO_KIBLA"], PromptEvent.PushType.NEXT1)
	EventManager.pop_back_to_current()

func fire_employee():
	employee_count -= 1
	employee_count_changed.emit(employee_count)
