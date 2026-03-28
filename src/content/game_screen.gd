class_name GameScreen extends MarginContainer

@onready var main_col: VBoxContainer = %MainCol

var next_question_button_scene: PackedScene = preload("res://src/ui/next_question_button.tscn")
var user_answer_button_scene: PackedScene = preload("res://src/dialogue/user_answer.tscn")

var next_question_button: NextQuestionButton

func _ready():
	ReplyManager.reply_completed.connect(_on_reply_completed)
	GameManager.next_question_started.connect(_on_next_question_started)

func _on_reply_completed(_prompt_reply: PromptReply):
	next_question_button = next_question_button_scene.instantiate()

	main_col.add_child(next_question_button)

func _on_next_question_started():
	if next_question_button:
		next_question_button.queue_free()
