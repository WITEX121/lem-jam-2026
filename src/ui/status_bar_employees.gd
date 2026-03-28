extends PanelContainer

@onready var count_label = $MarginContainer/HBoxContainer/Label2

func _ready() -> void:
	GameManager.employee_count_changed.connect(_on_employee_count_changed)

func set_status_bar(_target_value: float, _duration: float = 0.5):
	# dummy so i dont have to change logic in main scene
	pass

func _on_employee_count_changed(_new_count: int):
	count_label.text = str(GameManager.employee_count)
