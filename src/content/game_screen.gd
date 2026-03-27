class_name GameScreen extends MarginContainer

@onready var main_col: VBoxContainer = %MainCol

var next_question_button_scene: PackedScene = preload("res://src/next_question_button.tscn")


func _ready():
	print("Game screen ready")
	ReplyManager.reply_completed.connect(_on_reply_completed)


func _on_reply_completed(_prompt_reply: PromptReply):
	print("Reply completed")
	var next_question_button: NextQuestionButton = next_question_button_scene.instantiate()
	main_col.add_child(next_question_button)