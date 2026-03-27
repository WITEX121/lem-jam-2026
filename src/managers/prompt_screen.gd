extends Control

@onready var sentence_begin = %SentenceBegin
@onready var sentence_fill = %SentenceFill
@onready var sentence_end = %SentenceEnd

@onready var user_prompt = %UserPrompt

func _ready() -> void:
	GameManager.events_manager.event_started.connect(on_event_started)

	GameManager.game_start()

func on_event_started(event: PromptEvent):
	user_prompt.text = event.text
	sentence_begin.select(-1)
	sentence_fill.select(-1)
	sentence_end.select(-1)

func _on_button_pressed() -> void:
	GameManager.events_manager.pop_back_to_current()
