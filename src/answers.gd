class_name Answers extends VBoxContainer

@export var answer_button_scene: PackedScene = preload("res://src/answer_button/answer_button.tscn")

func _ready():
	GameManager.new_answers_ready.connect(_on_new_answers_ready)

func _on_new_answers_ready(possible_replies: Array[ReplyElement]):
	for reply: ReplyElement in possible_replies:
		var answer_button: AnswerButton = answer_button_scene.instantiate()
		answer_button.reply_element = reply
		await get_tree().create_timer(0.2).timeout
		add_child(answer_button)
