extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ReplyManager.text_on_change.connect(_on_change)
	GameManager.new_question.connect(func(): text = "Myślę nad rozwiązaniem")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_change(reply: String):
	text = reply
