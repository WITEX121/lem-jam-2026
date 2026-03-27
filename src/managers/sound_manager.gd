extends Node

var select: Sound = preload("res://const_data/sounds/select.tres")

func play_sound(sound: Sound):
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = sound.audio_stream
	audio_player.play()
	audio_player.finished.connect(audio_player.queue_free)
