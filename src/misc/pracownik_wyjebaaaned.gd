class_name PracownikWyjebaaaned extends PanelContainer

var time_elapsed: float = 0

func _ready():
	var center_pos = position
	self.position += Vector2(-2000, 0)
	var tween = create_tween()
	
	tween.tween_interval(1.0)
	await tween.finished
	SoundManager.play_sound(SoundManager.pracownik_wyjebaned)

	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", center_pos, 0.5)
	tween.tween_interval(1.0)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", center_pos + Vector2(2000, 0), 0.5)



# func _process(delta):
# 	time_elapsed += delta
# 	var vel = (1 - sin(time_elapsed * PI / 1.45)) * 2
# 	print(vel)
# 	global_position.x += vel * 70
# 	if time_elapsed > 3:
# 		queue_free()