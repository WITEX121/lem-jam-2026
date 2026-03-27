extends Node

var elevator: Sound = preload("res://const_data/sounds/elevator.tres")

var select: Sound = preload("res://const_data/sounds/select.tres")
var pracownik_wyjebaned: Sound = preload("res://const_data/sounds/pracownik_wyjebaned.tres")

var main_music_player: AudioStreamPlayer

func _ready():
	main_music_player = AudioStreamPlayer.new()
	main_music_player.bus = "Music"
	main_music_player.autoplay = true
	add_child(main_music_player)
	main_music_player.stream = elevator.audio_stream
	main_music_player.finished.connect(_loop_music)
	_loop_music()
	
func _loop_music():
	main_music_player.play()
	

func play_sound(sound: Sound):
	var audio_player = AudioStreamPlayer.new()
	audio_player.bus = "SFX"
	add_child(audio_player)
	audio_player.stream = sound.audio_stream
	audio_player.play()
	audio_player.finished.connect(audio_player.queue_free)
