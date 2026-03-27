extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var reply_manager = ReplyManager
	reply_manager.text_on_change.connect(_on_reply)


func _on_reply(reply: String):
	text = reply + '\n\n'
