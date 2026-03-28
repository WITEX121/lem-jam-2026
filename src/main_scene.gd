extends CanvasLayer

@onready var welcome_screen = %WelcomeScreen
@onready var start_button = $MainLayout/WelcomeScreen/VBoxContainer/BeginButton
@onready var status_bar_money = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status1
@onready var status_bar_morality = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status2
@onready var status_bar_pr = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status3
@onready var status_bar_trust = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status4
@onready var status_bar_employee_count = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status5
@onready var main_layout: VBoxContainer = %MainLayout

@onready var loading_screen := %LoadingScreen

var pracownik_wyjebaned_efekt_scene: PackedScene = preload("res://src/misc/pracownik_wyjebaaaned.tscn")
var game_screen_scene: PackedScene = preload("res://src/content/game_screen.tscn")
var game_over_scene: PackedScene = preload("res://src/content/game_over_scene.tscn")

func _ready() -> void:
	start_button.pressed.connect(start_game)
	GameManager.ratings.ratings_changed.connect(_rating_changed)
	GameManager.end_game.connect(end_game)
	GameManager.employee_count_changed.connect(_employee_count_changed)

	loading_screen.loading_finished.connect(welcome_screen.show_animation)

func start_game():
	SoundManager.play_sound(SoundManager.select)
	var status_bars = [status_bar_money, status_bar_morality, status_bar_pr, status_bar_trust, status_bar_employee_count]

	var tween = create_tween()
	tween.set_parallel(true)

	for bar in status_bars:
		bar.modulate.a = 0.0
		bar.show()
		bar.set_status_bar(50, 1)
		tween.tween_property(bar, "modulate:a", 1.0, 1.0)

	welcome_screen.queue_free()
	var game_screen = game_screen_scene.instantiate()
	main_layout.add_child(game_screen)

	EventManager.unlock_events_shuffle(Consts.BASE_EVENTS)
	GameManager.next_question_started.emit()

func _rating_changed():
	var status_bars = [status_bar_money, status_bar_morality, status_bar_pr, status_bar_trust]
	var values = [
		GameManager.ratings.get_rating(Ratings.Type.MONEY),
		GameManager.ratings.get_rating(Ratings.Type.MORALITY),
		GameManager.ratings.get_rating(Ratings.Type.PR),
		GameManager.ratings.get_rating(Ratings.Type.TRUST)
	]

	for i in range(len(values)):
		status_bars[i].set_status_bar(values[i])

func _employee_count_changed(_count: int):
	var pracownik_wyjebaned = pracownik_wyjebaned_efekt_scene.instantiate()
	add_child(pracownik_wyjebaned)

func end_game():
	var child_node = game_over_scene.instantiate()
	self.add_child(child_node)
