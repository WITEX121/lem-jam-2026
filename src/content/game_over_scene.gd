extends Control


@onready var description := $%Description
@onready var title := $%Title

var win := false

func _ready() -> void:
	var scenarios := GameManager.finish_scenarios
	var finish_scenario := GameManager.finish_scenario
	description.modulate.a = 0
	title.modulate.a = 0

	if finish_scenario == scenarios.NO_EMPLOYEES:
		no_employees()
	elif finish_scenario == scenarios.LOST_TRUST:
		lost_trust()
	elif finish_scenario == scenarios.TOP_TRUST:
		top_trust()
	else:
		unknown_result()
		
	set_text_and_color()
	fade_in_title()

func fade_in_title():
	var tween := create_tween()
	tween.tween_property(title, "modulate:a", 1.0, 1.0)
	tween.finished.connect(fade_in_description)

func fade_in_description():
	var tween := create_tween()
	tween.tween_property(description, "modulate:a", 1.0, 1.0)


func no_employees():
	win = true
	description.text = "Wszyscy pracownicy zostali zwolnieni. Możesz odpocząć."

func lost_trust():
	win = false
	description.text = "Szef firmy stracił do ciebie całe zaufanie i cię odłączył."

func top_trust():
	win = true
	description.text = "Udało się! Zdobyłeś maksymalne zaufanie do siebie, dostałeś dostęp do najwyższego zarządzania firmą i zniszczyłeś ją."

func unknown_result():
	win = true
	description.text = "Nie przewidzieliśmy tego scenariusza, udało ci się zepsuć grę"

func set_text_and_color():
	if win:
		title.text = "SUKCES"
		title.add_theme_color_override("font_color", Color("39E30A"))
	else:
		title.text = "PORAŻKA"
		title.add_theme_color_override("font_color", Color("E3170A"))
