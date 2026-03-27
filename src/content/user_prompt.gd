class_name UserPrompt extends PanelContainer

@onready var contents: Label = %Contents

func _ready():
	GameManager.new_question.connect(_on_new_question)

var _add_buffer: String = ""
var _elapsed := 0.0

func _process(delta: float) -> void:
	_elapsed += delta
	if not _add_buffer.is_empty() and _elapsed >= Consts.TYPE_SPEED:
		var next_char = _add_buffer[0]

		contents.text += next_char

		_add_buffer = _add_buffer.substr(1)
		_elapsed = 0

func set_text(text: String):
	contents.text = ""
	_add_buffer = text

func _on_new_question(question: String):
	contents.text = question
	GameManager.start_answer.emit()
