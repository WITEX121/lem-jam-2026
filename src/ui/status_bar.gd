extends PanelContainer

@onready var progress_bar = $MarginContainer/HBoxContainer/ProgressBar
@onready var progress_bar_stylebox: StyleBoxFlat = progress_bar.get_theme_stylebox("fill")
@onready var label = $MarginContainer/HBoxContainer/Label

@export var label_text: String = ""


func _ready() -> void:
	label.text = label_text
	

func _on_progress_bar_value_changed(value: float) -> void:
	progress_bar_stylebox.bg_color = Color(1, 1, value/100)
