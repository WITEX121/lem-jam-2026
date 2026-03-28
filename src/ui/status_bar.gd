extends PanelContainer

@onready var progress_bar = $MarginContainer/HBoxContainer/ProgressBar
@onready var progress_bar_stylebox: StyleBoxFlat = progress_bar.get_theme_stylebox("fill").duplicate()
@onready var label = $MarginContainer/HBoxContainer/Label
@onready var icon = $MarginContainer/HBoxContainer/Icon

@export var label_text: String
@export var icon_texture: Texture2D
var value: float
var old_value: float
var tween: Tween
var modulate_tween := create_tween()

const BASE_MODULATE := Color(1, 1, 1, 1)
const POSITIVE_MODULATE := Color(0.65, 1, 0.65, 1)
const NEGATIVE_MODULATE := Color(1, 0.65, 0.65, 1)

func _ready() -> void:
	label.text = label_text
	icon.texture = icon_texture
	modulate = BASE_MODULATE
	modulate_tween.stop()

func _on_progress_bar_value_changed(val: float) -> void:
	progress_bar_stylebox.bg_color = get_progress_color(val)
	progress_bar.add_theme_stylebox_override("fill", progress_bar_stylebox)
	if !modulate_tween.is_running():
		if val > old_value:
			_modulate_positively()
		elif val < old_value:
			_modulate_negatively()
	old_value = val

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

func _modulate_positively() -> void:
	if modulate_tween and modulate_tween.is_running():
		modulate_tween.kill()

	modulate_tween = create_tween()
	modulate_tween.set_trans(Tween.TRANS_SINE)
	modulate_tween.set_ease(Tween.EASE_OUT)
	modulate_tween.tween_property(self , "modulate", POSITIVE_MODULATE, 0.4)
	modulate_tween.tween_property(self , "modulate", BASE_MODULATE, 0.8)

func _modulate_negatively() -> void:
	if modulate_tween and modulate_tween.is_running():
		modulate_tween.kill()

	modulate_tween = create_tween()
	modulate_tween.set_trans(Tween.TRANS_SINE)
	modulate_tween.set_ease(Tween.EASE_OUT)
	modulate_tween.tween_property(self , "modulate", NEGATIVE_MODULATE, 0.4)
	modulate_tween.tween_property(self , "modulate", BASE_MODULATE, 0.8)
