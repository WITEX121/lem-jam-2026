class_name Answers extends VBoxContainer

@export var answer_button_scene: PackedScene = preload("res://src/answer_button/answer_button.tscn")

func _ready():
	for child in get_children():
		child.queue_free()
	ReplyManager.new_answers_ready.connect(_on_new_answers_ready)
	ReplyManager.init_data()

func _on_new_answers_ready(possible_replies: Array[ReplyElement]):
	await get_tree().create_timer(0.4).timeout
	for reply: ReplyElement in possible_replies:
		var answer_button: AnswerButton = answer_button_scene.instantiate()
		answer_button.reply_element = reply
		answer_button.prepare_for_spawn()
		add_child(answer_button)
		answer_button.play_intro()
