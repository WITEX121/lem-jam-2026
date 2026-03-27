extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var reply_manager = GameManager.replies_manager
	reply_manager.reply_completed.connect(_on_reply)

	var starst = reply_manager.get_starts()
	var fillers = reply_manager.get_fillers()
	var ends = reply_manager.get_ends()

	for i in range(3):
		reply_manager.load_element(starst[i])
		reply_manager.load_element(fillers[i])
		reply_manager.load_element(ends[i])

func _on_reply(reply: PromptReply):
	text += reply.get_text() + '\n\n'
