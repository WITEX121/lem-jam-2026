extends PanelContainer

@onready var progress_bar = $MarginContainer/HBoxContainer/ProgressBar
@onready var progress_bar_stylebox: StyleBoxFlat = progress_bar.get_theme_stylebox("fill").duplicate()
@onready var label = $MarginContainer/HBoxContainer/Label
@onready var icon = $MarginContainer/HBoxContainer/Icon

@export var label_text: String
@export var icon_texture: Texture2D
var value: float
var tween: Tween

func _ready() -> void:
	label.text = label_text
	icon.texture = icon_texture

func _on_progress_bar_value_changed(value: float) -> void:
	progress_bar_stylebox.bg_color = get_progress_color(value)
	progress_bar.add_theme_stylebox_override("fill", progress_bar_stylebox)

func set_status_bar(target_value: float, duration: float = 0.5):
	if tween and tween.is_running():
		tween.kill()
		
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.tween_property(progress_bar, "value", target_value, duration)

func get_progress_color(val: float) -> Color:
	var red = Color("E3170A")
	var yellow = Color("E3DC0A")
	var green = Color("39E30A")

	val = clamp(val, 0.0, 100.0)
	if val <= 50.0:
		var weight = val / 50.0
		return red.lerp(yellow, weight)
	else:
		var weight = (val - 50.0) / 50.0
		return yellow.lerp(green, weight)
