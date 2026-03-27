class_name LoadingAnimation extends HBoxContainer

signal _start_next_anim

@onready var circle_1: TextureRect = %Circle1
@onready var circle_2: TextureRect = %Circle2
@onready var circle_3: TextureRect = %Circle3

@export var base_color: Color
@export var in_anim_color: Color

var tween: Tween

var base_position_circle_1: Vector2
var base_position_circle_2: Vector2
var base_position_circle_3: Vector2

func _ready():
	await get_tree().process_frame
	base_position_circle_1 = circle_1.position
	base_position_circle_2 = circle_2.position
	base_position_circle_3 = circle_3.position
	_start_next_anim.connect(_start_anim)
	_start_anim()
	ReplyManager.reply_completed.connect(func(_e): visible = false)
	EventManager.event_started.connect(func(): visible = true)


func _start_anim():
	tween = create_tween()
	tween.set_parallel()

	tween.tween_property(circle_1, "position", base_position_circle_1 + Vector2(0, -12), 0.5).set_trans(Tween.TransitionType.TRANS_CUBIC)
	tween.tween_property(circle_1, "position", base_position_circle_1, 0.5).set_delay(0.5).set_trans(Tween.TransitionType.TRANS_CUBIC)
	tween.tween_property(circle_1, "modulate", in_anim_color, 0.5).set_trans(Tween.TransitionType.TRANS_CUBIC)
	tween.tween_property(circle_1, "modulate", base_color, 0.5).set_delay(0.5).set_trans(Tween.TransitionType.TRANS_CUBIC)

	tween.tween_property(circle_2, "position", base_position_circle_2 + Vector2(0, -12), 0.5).set_delay(0.25).set_trans(Tween.TransitionType.TRANS_CUBIC)
	tween.tween_property(circle_2, "position", base_position_circle_2, 0.5).set_delay(0.75).set_trans(Tween.TransitionType.TRANS_CUBIC)
	tween.tween_property(circle_2, "modulate", in_anim_color, 0.5).set_delay(0.25).set_trans(Tween.TransitionType.TRANS_CUBIC)
	tween.tween_property(circle_2, "modulate", base_color, 0.5).set_delay(0.75).set_trans(Tween.TransitionType.TRANS_CUBIC)

	tween.tween_property(circle_3, "position", base_position_circle_3 + Vector2(0, -12), 0.5).set_delay(0.5).set_trans(Tween.TransitionType.TRANS_CUBIC)
	tween.tween_property(circle_3, "position", base_position_circle_3, 0.5).set_delay(1.0).set_trans(Tween.TransitionType.TRANS_CUBIC)
	tween.tween_property(circle_3, "modulate", in_anim_color, 0.5).set_delay(0.5).set_trans(Tween.TransitionType.TRANS_CUBIC)
	tween.tween_property(circle_3, "modulate", base_color, 0.5).set_delay(1.0).set_trans(Tween.TransitionType.TRANS_CUBIC)
	await tween.finished
	if is_inside_tree():
		_start_next_anim.emit()
