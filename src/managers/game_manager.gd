extends Node

signal next_question
signal new_question(question: String)
signal start_answer()
signal reload_prompt()
signal end_game

signal answer_provided(answer: String)
signal employee_count_changed(employee_count: int)

enum finish_scenarios {
	NOT_FINISHED,
	NO_EMPLOYEES,
	LOST_TRUST,
	TOP_TRUST,
	LOST_MONEY,
	TOP_MONEY,
	LOST_MORALITY,
	TOP_MORALITY,
	LOST_PR,
	TOP_PR
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

func _ready() -> void:
	next_question.connect(func(): new_question.emit(EventManager.current_event.text))
	ratings.ratings_changed.connect(_on_ratings_changed)
	employee_count_changed.connect(_on_employee_count_changed)

func _on_employee_count_changed(_count: int):
	var pracownik_wyjebaned = pracownik_wyjebaned_efekt_scene.instantiate()
	add_child(pracownik_wyjebaned)	

func fire_employee():
	employee_count -= 1
	employee_count_changed.emit(employee_count)

func _on_ratings_changed():
	if ratings.get_rating(Ratings.Type.MONEY) >= 100:
		finish_scenario = finish_scenarios.TOP_MONEY
	elif ratings.get_rating(Ratings.Type.MONEY) <= 0:
		finish_scenario = finish_scenarios.LOST_MONEY
	elif ratings.get_rating(Ratings.Type.PR) >= 100:
		finish_scenario = finish_scenarios.TOP_PR
	elif ratings.get_rating(Ratings.Type.PR) <= 0:
		finish_scenario = finish_scenarios.LOST_PR
	elif ratings.get_rating(Ratings.Type.MORALITY) >= 100:
		finish_scenario = finish_scenarios.TOP_MORALITY
	elif ratings.get_rating(Ratings.Type.MORALITY) <= 0:
		finish_scenario = finish_scenarios.LOST_MORALITY
	elif ratings.get_rating(Ratings.Type.TRUST) >= 100:
		finish_scenario = finish_scenarios.TOP_TRUST
	elif ratings.get_rating(Ratings.Type.TRUST) <= 0:
		finish_scenario = finish_scenarios.LOST_TRUST
	if finish_scenario != finish_scenarios.NOT_FINISHED:
		end_game.emit()
