class_name UserPrompt extends PanelContainer


@onready var contents: Label = %Contents

func _ready():
	GameManager.new_question.connect(_on_new_question)

func _on_new_question(question: String):
	var tween: Tween = create_tween()
	await tween.tween_property(contents, "modulate:a", 0, 0.3).finished
	contents.text = question
	await tween.tween_property(contents, "modulate:a", 255, 0.3).finished
	GameManager.start_answer.emit()
