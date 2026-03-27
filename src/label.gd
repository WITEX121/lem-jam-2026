extends Label

var reply_manager: ReplyList = preload("res://const_data/prompt_reply/reply_list.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var result = ''
	for i in range(3):
		var reply = reply_manager.random_reply()
		result += reply.get_text() + '\n' + str(reply.get_weight()) + '\n\n'

	text = result
