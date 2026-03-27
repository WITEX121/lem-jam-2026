class_name GameScreen extends MarginContainer

@onready var main_col: VBoxContainer = %MainCol

var next_question_button_scene: PackedScene = preload("res://src/next_question_button.tscn")
var user_answer_button_scene: PackedScene = preload("res://src/user_answer.tscn")

var user_answer: UserAnswer
var next_question_button: NextQuestionButton

func _ready():
	ReplyManager.reply_completed.connect(_on_reply_completed)
	GameManager.new_question.connect(_on_new_question)

func _on_reply_completed(_prompt_reply: PromptReply):
	next_question_button = next_question_button_scene.instantiate()
	GameManager.answer_provided.emit("TODO: DODAĆ TEKST ODPOWIEDZI")
	main_col.add_child(next_question_button)

func _on_new_question(_question: String):
	if next_question_button:
		next_question_button.queue_free()
