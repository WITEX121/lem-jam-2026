class_name PracownikWyjebaaaned extends PanelContainer

var time_elapsed: float = 0

func _ready():
	global_position = Vector2(-1440, 360.0)
	SoundManager.play_sound(SoundManager.pracownik_wyjebaned)


func _process(delta):
	time_elapsed += delta
	var vel = (1 - sin(time_elapsed * PI / 1.45)) * 2
	print(vel)
	global_position.x += vel * 70
	if time_elapsed > 3:
		queue_free()