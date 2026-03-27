class_name AnswerButton extends Button


@export var _normal_color: Color
@export var _hover_color: Color
@export var reply_element: ReplyElement

@onready var _reply_label: Label = %ReplyLabel
@onready var _background: PanelContainer = %Background


var _stylebox: StyleBoxFlat
var _current_background_color: Color

var _is_mouse_on_top: bool = false

func _ready():
	_current_background_color = _normal_color
	_reply_label.text = reply_element.text
	_stylebox = _background.get_theme_stylebox("panel")
	_stylebox.bg_color = _current_background_color
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)


func _process(_delta):
	if _is_mouse_on_top:
		_current_background_color = _current_background_color.lerp(_hover_color, 0.4)
		Input.set_custom_mouse_cursor(GameManager.cursor_button)
	else:
		_current_background_color = _current_background_color.lerp(_normal_color, 0.4)
		Input.set_custom_mouse_cursor(GameManager.cursor_arrow)

	_stylebox.bg_color = _current_background_color


func _on_mouse_entered():
	_is_mouse_on_top = true

func _on_mouse_exited():
	_is_mouse_on_top = false

func _on_pressed():
	GameManager.replies_manager.load_element(reply_element)
