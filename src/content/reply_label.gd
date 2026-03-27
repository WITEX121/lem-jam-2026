extends Label


func _ready() -> void:
	ReplyManager.text_on_change.connect(_on_change)
	GameManager.next_question.connect(func(): text = "Myślę nad rozwiązaniem")


func _on_change(reply: String):
	text = reply
