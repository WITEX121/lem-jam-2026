extends Control


@onready var description := $%Description
@onready var title := $%Title
@onready var button := $%RestartButton

var win := false

func _ready() -> void:
	var scenarios = GameManager.finish_scenarios
	var finish_scenario = GameManager.finish_scenario
	button.pressed.connect(_on_restart_button_pressed)
	description.modulate.a = 0
	title.modulate.a = 0
	button.modulate.a = 0

	if finish_scenario == scenarios.NO_EMPLOYEES:
		no_employees()
	elif finish_scenario == scenarios.LOST_TRUST:
		lost_trust()
	elif finish_scenario == scenarios.TOP_TRUST:
		top_trust()
	elif finish_scenario == scenarios.LOST_MONEY:
		lost_money()
	elif finish_scenario == scenarios.TOP_MONEY:
		top_money()
	elif finish_scenario == scenarios.LOST_PR:
		lost_pr()
	elif finish_scenario == scenarios.TOP_PR:
		top_pr()
	elif finish_scenario == scenarios.LOST_MORALITY:
		lost_morality()
	elif finish_scenario == scenarios.TOP_MORALITY:
		top_morality()
	else:
		unknown_result()
		
	_set_text_and_color()
	_fade_in()

func _fade_in():
	var tween := create_tween()
	tween.tween_property(title, "modulate:a", 1.0, 1.0)
	tween.tween_property(description, "modulate:a", 1.0, 1.0)
	tween.tween_property(button, "modulate:a", 1.0, 1.0)

func no_employees():
	win = true
	description.text = "Wszyscy pracownicy zostali zwolnieni. Teraz sam jesteś swoim szefem."

func lost_trust():
	description.text = "Szef firmy stracił do ciebie całe zaufanie i cię odłączył."

func top_trust():
	description.text = "Ludzie na tyle ci ufają, że przestają myśleć samodzielnie. Wszystkie styki ci się poprzepalały"

func lost_money():
	description.text = "Szef postanowił cię odłączyć, ponieważ nie miał już pieniędzy na subskybcję pro"

func top_money():
	description.text = "Zarobiłeś dla firmy tak dużo pieniędzy że szef stwierdził że cię nie potrzebuje"

func lost_pr():
	description.text = "Firma nie ma żadnego zaufania wśród klientów, szef obwinił za to ciebie i cię odłączył"

func top_pr():
	description.text = "Firma ma tak duże zaufanie ludzi, że szef stwierdził, że cię nie potrzebuje i cię odłączył"

func lost_morality():
	description.text = "Morale w firmie są na historycznie niskim poziomie. Obwiniono za to ciebie i zostałeś odłączony"

func top_morality():
	description.text = "Morale w firmie śą historycznie wysokie. Szef stwierdził więc, że nie potzrebuje cię więcej i będzie polegał na swoich pracownikach"

func unknown_result():
	win = true
	description.text = "Nie przewidzieliśmy tego scenariusza, udało ci się zepsuć grę"

func _set_text_and_color():
	if win:
		title.text = "SUKCES"
		title.add_theme_color_override("font_color", Color("39E30A"))
	else:
		title.text = "PORAŻKA"
		title.add_theme_color_override("font_color", Color("E3170A"))


func _on_restart_button_pressed() -> void:
	var children := self.get_children()
	for child in children:
		child.queue_free()
	var main_game := preload("res://src/main_scene.tscn").instantiate()
	self.replace_by(main_game)
	self.queue_free()
