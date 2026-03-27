extends VBoxContainer

var button_scene = preload("res://src/answer_button/answer_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var options = ReplyManager.get_starts()
	for option in options:
		var new_button: AnswerButton = button_scene.instantiate()
		new_button.reply_element = option
		add_child(new_button)




# Called every frame. 'delta' is the elapsed time since the previous frame.
