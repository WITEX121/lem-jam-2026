extends Control

@onready var progress_bar = $CenterContainer/VBoxContainer/ProgressBar

func _ready() -> void:
	progress_bar.value = 0.0
	simulate_loading()

func simulate_loading():
	var tween = create_tween()
	
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.tween_property(progress_bar, "value", 100.0, 2.5)
	tween.finished.connect(go_to_main_menu)

func go_to_main_menu():
	self.queue_free()
