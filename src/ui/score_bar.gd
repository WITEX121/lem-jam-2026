extends TextureRect

@onready var pointer_rotation_point: Control = %Pivot
var tween_rotation: Tween = null

func _ready() -> void:
	GameManager.next_question_started.connect(show_animation)
	GameManager.next_question_started.connect(reset_rotation)

	ReplyManager.text_on_change.connect(handle_rotation)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		reset_physics_interpolation()

func _exit_tree() -> void:
	tween_rotation.kill()

func show_animation():
	visible = true

	modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)

	# Run only once on start
	GameManager.next_question_started.disconnect(show_animation)

func reset_rotation():
	set_target_rotation(0.0, Tween.TransitionType.TRANS_EXPO, 0.5)

func handle_rotation(__):
	var reply = ReplyManager._reply
	var normalised = reply.get_weight() / Consts.ANIMATION_WEIGHT_NORMALISE_THRESHOLD
	normalised = clamp(normalised, -1.0, 1.0)

	set_target_rotation(normalised * PI/2.0)

func set_target_rotation(target_rotation: float, 
						 trans: Tween.TransitionType = Tween.TRANS_ELASTIC,
						 time: float = 0.75):
	if tween_rotation and tween_rotation.is_running():
		tween_rotation.kill()

	tween_rotation = get_tree().create_tween()
	tween_rotation.set_trans(trans)
	tween_rotation.tween_property(pointer_rotation_point, "rotation", target_rotation, time)

# func _physics_process(_delta: float) -> void:
	#pointer_rotation_point.rotation = lerp_angle(pointer_rotation_point.rotation, target_rotation, 0.1)
