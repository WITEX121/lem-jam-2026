class_name Answers extends VBoxContainer

@export var answer_button_scene: PackedScene = preload("res://src/answer_button/answer_button.tscn")

func _ready():
	for child in get_children():
		child.queue_free()
	ReplyManager.new_answers_ready.connect(_on_new_answers_ready)
	ReplyManager.init_data()

func _show_button_after_while(button: AnswerButton):
	await get_tree().create_timer(0.05).timeout
	button.visible = true
	

func _on_new_answers_ready(possible_replies: Array[ReplyElement]):
	await get_tree().create_timer(0.4).timeout
	for reply: ReplyElement in possible_replies:
		var answer_button: AnswerButton = answer_button_scene.instantiate()
		answer_button.visible = false
		answer_button.position += Vector2(4000, 0)
		_show_button_after_while(answer_button)
		answer_button.reply_element = reply
		add_child(answer_button)
