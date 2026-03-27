extends Control


@onready var description := $%Description
@onready var title := $%Title

var win := false

func _ready() -> void:
	var scenarios = GameManager.finish_scenarios
	var finish_scenario = GameManager.finish_scenario
	description.modulate.a = 0
	title.modulate.a = 0

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
	description.text = "Szef firmy stracił do ciebie całe zaufanie i cię odłączył."

func top_trust():
	description.text = "Zdobyłeś maksymalne zaufanie do siebie więc przegrałeś (z jakiegoś powodu)"

func lost_money():
	description.text = "Szef firmy stracił do ciebie całe zaufanie i cię odłączył."

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

func set_text_and_color():
	if win:
		title.text = "SUKCES"
		title.add_theme_color_override("font_color", Color("39E30A"))
	else:
		title.text = "PORAŻKA"
		title.add_theme_color_override("font_color", Color("E3170A"))
