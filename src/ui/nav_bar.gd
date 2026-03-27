extends PanelContainer

@onready var back_button = $MarginContainer/HBoxContainer/Controls/BackButton
@onready var forward_button = $MarginContainer/HBoxContainer/Controls/ForwardButton
@onready var refresh_button = $MarginContainer/HBoxContainer/Controls/RefreshButton
@onready var search_bar = $MarginContainer/HBoxContainer/SearchBar
@onready var timer = $Timer

var default_text = "www.CorpAI.com"
var reaction_texts = [
	"Co ty robisz?",
	"Wracaj do odpowadania",
	"To nic nie robi",
	"Przestań się bawić",
	"Do roboty"
]

var rare_text = "Ten tekst jest bardzo rzadki"

func _ready() -> void:
	back_button.pressed.connect(_on_button_pressed)
	forward_button.pressed.connect(_on_button_pressed)
	refresh_button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	SoundManager.play_sound(SoundManager.select)
	if randi_range(0, 100) == 50:
		search_bar.text = rare_text
	else:
		var new_text = reaction_texts[randi() % reaction_texts.size()]
		while new_text == search_bar.text:
			new_text = reaction_texts[randi() % reaction_texts.size()]
		search_bar.text = new_text
	timer.start(3)

func _on_timer_timeout() -> void:
	search_bar.text = default_text
