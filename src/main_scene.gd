extends CanvasLayer

@onready var welcome_screen = $MainLayout/WelcomeScreen
@onready var start_button = $MainLayout/WelcomeScreen/VBoxContainer/BeginButton
@onready var status_bar_money = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status1
@onready var status_bar_morality = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status2
@onready var status_bar_pr = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status3
@onready var status_bar_trust  = $MainLayout/MarginContainer/Header/Tabs/HBoxContainer/Status4

@onready var answers: Answers = %Answers

func _ready() -> void:
	start_button.pressed.connect(start_game)
	GameManager.ratings.ratings_changed.connect(_rating_changed)

func start_game():
	SoundManager.play_sound(SoundManager.select)
	var status_bars = [status_bar_money, status_bar_morality, status_bar_pr, status_bar_trust]

	var tween = create_tween()
	tween.set_parallel(true) 

	for bar in status_bars:
		bar.modulate.a = 0.0
		bar.show()
		bar.set_status_bar(50, 1)
		tween.tween_property(bar, "modulate:a", 1.0, 1.0)

	welcome_screen.queue_free()
	answers.show()

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