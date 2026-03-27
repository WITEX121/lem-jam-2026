class_name NextQuestionButton extends Button

@export_group("Styling")
@export var _normal_color: Color = Color8(49, 51, 53, 127)
@export var _hover_color: Color = Color8(236, 154, 41, 255)
@export var _pressed_color: Color = Color8(0, 119, 181, 255)
@export var _normal_font: Font = preload("res://assets/fonts/RethinkSans-MediumItalic.ttf")
@export var _hover_font: Font = preload("res://assets/fonts/RethinkSans-BoldItalic.ttf")
@export var _offset: float = 4400.0

@onready var _reply_label: Label = %ReplyLabel
@onready var _background: PanelContainer = %Background
@onready var _margin_container: MarginContainer = $MarginContainer

var tween: Tween
var _stylebox: StyleBoxFlat
var _current_background_color: Color

var _is_mouse_on_top: bool = false
var _is_pressed: bool = false

func _ready():
	_current_background_color = _normal_color
	_stylebox = _background.get_theme_stylebox("panel")
	_stylebox = _stylebox.duplicate() # To avoid changing the original stylebox
	_background.add_theme_stylebox_override("panel", _stylebox)
	_stylebox.bg_color = _current_background_color


	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	_set_content_x(_offset)
	play_intro()


func prepare_for_spawn():
	visible = false


func _set_content_x(value: float):
	_background.position.x = value
	_margin_container.position.x = value


func play_intro():
	_set_content_x(_offset)
	visible = true

	if is_instance_valid(tween):
		tween.kill()

	tween = create_tween()
	tween.set_trans(Tween.TransitionType.TRANS_QUAD)
	tween.parallel().tween_property(_background, "position:x", 0.0, 0.3)
	tween.parallel().tween_property(_margin_container, "position:x", 0.0, 0.3)


func _process(_delta):
	if _is_pressed: # PRESSED
		_animate_press()
	elif _is_mouse_on_top: # HOVER
		_animate_hover()
	else: # NORMAL
		_animate_normal()

	_stylebox.bg_color = _current_background_color


func _on_mouse_entered():
	_is_mouse_on_top = true
	Input.set_custom_mouse_cursor(GameManager.cursor_button)

func _on_mouse_exited():
	_is_mouse_on_top = false
	Input.set_custom_mouse_cursor(GameManager.cursor_arrow)

func _on_pressed():
	_is_pressed = true
	SoundManager.play_sound(SoundManager.select)
	GameManager.next_question.emit()
	ReplyManager.init_data()
	_animate_out()


func _disable_button():
	mouse_entered.disconnect(_on_mouse_entered)
	mouse_exited.disconnect(_on_mouse_exited)
	Input.set_custom_mouse_cursor(GameManager.cursor_arrow)
	disabled = true

func _animate_press():
	_current_background_color = _current_background_color.lerp(_pressed_color, 0.4)
	_stylebox.border_color = _current_background_color

func _animate_hover():
	_current_background_color = _current_background_color.lerp(_hover_color, 0.4)
	_reply_label.add_theme_font_override("font", _hover_font)

func _animate_normal():
	_current_background_color = _current_background_color.lerp(_normal_color, 0.4)
	_reply_label.add_theme_font_override("font", _normal_font)

func _animate_out():
	if is_instance_valid(tween):
		tween.kill()

	tween = create_tween()
	tween.set_trans(Tween.TransitionType.TRANS_QUAD)
	tween.parallel().tween_property(_background, "position:x", _offset, 0.3)
	tween.parallel().tween_property(_margin_container, "position:x", _offset, 0.3)
	await get_tree().create_timer(0.3).timeout

	queue_free()
