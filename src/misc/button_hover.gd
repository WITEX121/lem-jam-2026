extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	Input.set_custom_mouse_cursor(GameManager.cursor_button)

func _on_mouse_exited():
	Input.set_custom_mouse_cursor(GameManager.cursor_arrow)
