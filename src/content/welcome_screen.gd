extends MarginContainer

func show_animation():
    visible = true

    modulate.a = 0.0
    var tween = get_tree().create_tween()
    tween.tween_property(self, "modulate:a", 1.0, 1.0)