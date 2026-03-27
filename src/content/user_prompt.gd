class_name UserPrompt extends PanelContainer

@onready var contents: Label = %Contents

func _ready():
	# JAK NOWE PYTANIE TO POKAZUJEMY JE #KAROL
	GameManager.new_question.connect(_on_new_question)

var _add_buffer: String = "PRZYBIEŻELI DO BUTELKI WE CZTERECH"
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
	var tween: Tween = create_tween()
	await tween.tween_property(contents, "modulate:a", 0, 0.3).finished
	contents.text = question
	await tween.tween_property(contents, "modulate:a", 255, 0.3).finished
	GameManager.start_answer.emit()