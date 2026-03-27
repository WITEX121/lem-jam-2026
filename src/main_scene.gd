extends CanvasLayer

@onready var welcome_screen = $MainLayout/WelcomeScreen
@onready var start_button = $MainLayout/WelcomeScreen/VBoxContainer/BeginButton
@onready var status_bar_money = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status1
@onready var status_bar_morality = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status2
@onready var status_bar_pr = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status3
@onready var status_bar_trust = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status4
@onready var status_bar_employee_count = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status5
@onready var main_layout: VBoxContainer = %MainLayout

var game_screen_scene: PackedScene = preload("res://src/content/game_screen.tscn")

func _ready() -> void:
	EventManager.unlock_events_shuffle(Consts.BASE_EVENTS)
	EventManager.pop_back_to_current()

	start_button.pressed.connect(start_game)
	GameManager.ratings.ratings_changed.connect(_rating_changed)
	GameManager.end_game.connect(end_game)

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
	await get_tree().create_timer(2.0).timeout
	GameManager.new_question.emit(EventManager.current_event.text)

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
		print(values[i])

func end_game():
	self.get_tree().change_scene_to_file("res://src/content/game_over_scene.tscn")
