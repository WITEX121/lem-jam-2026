extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var reply_manager = GameManager.replies_manager
	reply_manager.text_on_change.connect(_on_reply)

	# var starst = reply_manager.get_starts()
	# var fillers = reply_manager.get_fillers()
	# var ends = reply_manager.get_ends()

	# reply_manager.load_element(starst[0])
	# reply_manager.load_element(fillers[0])
	# reply_manager.load_element(ends[0])


func _on_reply(reply: String):
	text = reply + '\n\n'
