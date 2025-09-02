extends Area3D

# preload or load multiple key press sounds
var key_sounds = [
	preload("res://assets/1D-sfx/key01.ogg"),
	preload("res://assets/1D-sfx/key02.ogg"),
	preload("res://assets/1D-sfx/key03.ogg"),
	preload("res://assets/1D-sfx/key04.ogg"),
]

var mouse_sounds = [
	preload("res://assets/1D-sfx/click01.ogg"),
	preload("res://assets/1D-sfx/click02.ogg"),
	preload("res://assets/1D-sfx/click03.ogg"),
	preload("res://assets/1D-sfx/click04.ogg"),
	preload("res://assets/1D-sfx/click05.ogg"),
	preload("res://assets/1D-sfx/click06.ogg"),
]

func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		play_random_key_sound()
	elif event is InputEventMouseButton and event.pressed:
		play_random_mouse_sound()

@onready var keyboard:= $KeyboardSounds
@onready var mouse:= $MouseSounds

func play_random_key_sound():
	var random_index = randi() % key_sounds.size()
	keyboard.stream = key_sounds[random_index]
	keyboard.play()

func play_random_mouse_sound():
	var random_index = randi() % mouse_sounds.size()
	mouse.stream = mouse_sounds[random_index]
	mouse.play()
