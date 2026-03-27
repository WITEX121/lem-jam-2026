class_name AnswerButton extends Button


@export var reply_element: ReplyElement

@export_group("Styling")
@export var _normal_color: Color = Color8(49, 51, 53, 127)
@export var _hover_color: Color = Color8(236, 154, 41, 255)
@export var _pressed_color: Color = Color8(0, 119, 181, 255)
@export var _normal_font: Font = preload("res://assets/fonts/RethinkSans-MediumItalic.ttf")
@export var _hover_font: Font = preload("res://assets/fonts/RethinkSans-BoldItalic.ttf")
@export var _offset: int = 4400

@onready var _reply_label: Label = %ReplyLabel
@onready var _background: PanelContainer = %Background

var tween: Tween
var _stylebox: StyleBoxFlat
var _current_background_color: Color

var _is_mouse_on_top: bool = false
var _is_pressed: bool = false

var _animate_in: bool = true

func _ready():
	_current_background_color = _normal_color
	_reply_label.text = reply_element.text
	_stylebox = _background.get_theme_stylebox("panel")
	_stylebox = _stylebox.duplicate() # To avoid changing the original stylebox
	_background.add_theme_stylebox_override("panel", _stylebox)
	_stylebox.bg_color = _current_background_color


	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	GameManager.new_answers_ready.connect(_on_new_answers_ready)
	GameManager.prompt_finished.connect(_on_prompt_finished)
	offset_left = _offset


func _process(delta):
	if _animate_in:
		_animate_in = false
		tween = create_tween()
		offset_left = _offset
		tween.tween_property(self , "offset_left", 0, 0.3).set_trans(Tween.TransitionType.TRANS_QUAD)


	if _is_pressed: # PRESSED
		_current_background_color = _current_background_color.lerp(_pressed_color, 0.4)
		_stylebox.border_color = _current_background_color
	elif _is_mouse_on_top: # HOVER
		_current_background_color = _current_background_color.lerp(_hover_color, 0.4)
		_reply_label.add_theme_font_override("font", _hover_font)
	else: # NORMAL
		_current_background_color = _current_background_color.lerp(_normal_color, 0.4)
		_reply_label.add_theme_font_override("font", _normal_font)

	_stylebox.bg_color = _current_background_color


func _on_mouse_entered():
	_is_mouse_on_top = true
	Input.set_custom_mouse_cursor(GameManager.cursor_button)

func _on_mouse_exited():
	_is_mouse_on_top = false
	Input.set_custom_mouse_cursor(GameManager.cursor_arrow)

func _on_pressed():
	_is_pressed = true
	# TODO: Pass info to GameManager about selection
	var test: Array[ReplyElement] = []
	GameManager.new_answers_ready.emit(test) # Clear answers
	SoundManager.play_sound(SoundManager.select)
	GameManager.reply_selected.emit()


func _on_new_answers_ready(_possible_replies: Array[ReplyElement]):
	_disable_button()
	_animate_out()

func _on_prompt_finished():
	_disable_button()
	_animate_out()

func _disable_button():
	mouse_entered.disconnect(_on_mouse_entered)
	mouse_exited.disconnect(_on_mouse_exited)
	Input.set_custom_mouse_cursor(GameManager.cursor_arrow)
	disabled = true

func _animate_out():
	tween = create_tween()

	tween.tween_property(self , "offset_left", _offset, 0.3).set_trans(Tween.TransitionType.TRANS_QUAD).as_relative()
	await get_tree().create_timer(0.3).timeout

	queue_free()
