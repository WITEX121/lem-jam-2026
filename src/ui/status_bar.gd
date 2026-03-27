extends PanelContainer

@onready var progress_bar = $MarginContainer/HBoxContainer/ProgressBar
@onready var progress_bar_stylebox: StyleBoxFlat = progress_bar.get_theme_stylebox("fill").duplicate()
@onready var label = $MarginContainer/HBoxContainer/Label

@export var label_text: String = ""

func _ready() -> void:
	label.text = label_text

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_0):
		progress_bar.value = randf_range(0, 100)

func _on_progress_bar_value_changed(value: float) -> void:
	var red = Color("E3170A")
	var yellow = Color("E3DC0A")
	var green = Color("39E30A")
	var target = Color("FFFFFF")

	value = clamp(value, 0.0, 100.0)
	if value <= 50.0:
		var weight = value / 50.0
		target = red.lerp(yellow, weight)
	else:
		var weight = (value - 50.0) / 50.0
		target = yellow.lerp(green, weight)

	progress_bar_stylebox.bg_color = target
	progress_bar.add_theme_stylebox_override("fill", progress_bar_stylebox)
