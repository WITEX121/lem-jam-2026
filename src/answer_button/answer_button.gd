class_name AnswerButton extends Button


@export var reply_element: ReplyElement

@export_group("Styling")
@export var _normal_color: Color = Color8(49, 51, 53, 127)
@export var _hover_color: Color = Color8(236, 154, 41, 255)
@export var _pressed_color: Color = Color8(0, 119, 181, 255)
@export var _pressed_border_color: Color = Color8(0, 119, 181, 255)
@export var _normal_font: Font = preload("res://assets/fonts/RethinkSans-MediumItalic.ttf")
@export var _hover_font: Font = preload("res://assets/fonts/RethinkSans-BoldItalic.ttf")


@onready var _reply_label: Label = %ReplyLabel
@onready var _background: PanelContainer = %Background


var _stylebox: StyleBoxFlat
var _current_background_color: Color

var _is_mouse_on_top: bool = false
var _is_pressed: bool = false

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


func _process(delta):
	if _is_pressed: # PRESSED
		_current_background_color = _current_background_color.lerp(_pressed_color, 0.4)
		_stylebox.border_color = _current_background_color

		Input.set_custom_mouse_cursor(GameManager.cursor_arrow)
	elif _is_mouse_on_top: # HOVER
		_current_background_color = _current_background_color.lerp(_hover_color, 0.4)
		_reply_label.add_theme_font_override("font", _hover_font)
		Input.set_custom_mouse_cursor(GameManager.cursor_button)
	else: # NORMAL
		_current_background_color = _current_background_color.lerp(_normal_color, 0.4)
		_reply_label.add_theme_font_override("font", _normal_font)
		Input.set_custom_mouse_cursor(GameManager.cursor_arrow)

	_stylebox.bg_color = _current_background_color


func _on_mouse_entered():
	_is_mouse_on_top = true

func _on_mouse_exited():
	_is_mouse_on_top = false

func _on_pressed():
	GameManager.replies_manager.load_element(reply_element)
	disabled = true
	_is_pressed = true
	SoundManager.play_sound(SoundManager.select)
	print("Selected: " + reply_element.text)
