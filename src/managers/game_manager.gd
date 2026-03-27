extends Node

signal next_question_started
signal end_game

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

var cursor_arrow = preload("res://assets/icons/pointer_a.png")
var cursor_button = preload("res://assets/icons/hand_point.png")

var ratings := Ratings.new(50, 50, 50, 50)
var employee_count: int = 10
var finish_scenario := finish_scenarios.NOT_FINISHED

# Constants
var _events := Parser.load_events()
var EVENTS:
	get: return _events

func _ready() -> void:
	ratings.ratings_changed.connect(_on_ratings_changed)
	# employee_count_changed.connect(_on_employee_count_changed)

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_0):
		fire_employee()

# func _on_employee_count_changed(_count: int):
# 	var pracownik_wyjebaned = pracownik_wyjebaned_efekt_scene.instantiate()
# 	add_child(pracownik_wyjebaned)

func fire_employee():
	employee_count -= 1
	employee_count_changed.emit(employee_count)
	if employee_count <= 0:
		finish_scenario = finish_scenarios.NO_EMPLOYEES
		end_game.emit()

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
