extends Control

@onready var sentence_begin = %SentenceBegin
@onready var sentence_fill = %SentenceFill
@onready var sentence_end = %SentenceEnd

@onready var user_prompt = %UserPrompt

func _ready() -> void:
	EventManager.event_started.connect(on_event_started)

	Parser.load_events()

func on_event_started(event: PromptEvent):
	user_prompt.text = event.text

func _on_button_pressed() -> void:
	EventManager.pop_back_to_current()


func _on_sentence_begin_item_selected(index: int) -> void:
	GameManager.selected = index
	pass # Replace with function body.
