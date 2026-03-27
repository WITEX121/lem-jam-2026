extends VBoxContainer

@onready var label = %Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ReplyManager.text_on_change.connect(func(reply: String): label.text = reply)
	GameManager.next_question.connect(func(): label.text = "Myślę nad rozwiązaniem")

