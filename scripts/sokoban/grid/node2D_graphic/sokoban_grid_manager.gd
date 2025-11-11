extends Node2D
class_name SokobanGridManager

var level_paths = [
	"res://scenes/puzzling/levels/Level1.tscn"
]

var current_level: SokobanGrid

func _ready():
	load_level(0)
	set_process_input(true)

func load_level(index: int):
	if current_level:
		current_level.queue_free()
	
	var scene = load(level_paths[index])
	current_level = scene.instantiate()
	add_child(current_level)

var moving: bool

var cooldown_time: float = 0.1
var cooldown: float = 0.0
var move_dir: String

func _process(delta):
	if !moving:
		if Input.is_action_pressed("char_up"):
			current_level.input(Vector2i.UP)
			moving = true
		elif Input.is_action_pressed("char_down"):
			current_level.input(Vector2i.DOWN)
			moving = true
		elif Input.is_action_pressed("char_left"):
			current_level.input(Vector2i.LEFT)
			moving = true
		elif Input.is_action_pressed("char_right"):
			current_level.input(Vector2i.RIGHT)
			moving = true
			
		elif Input.is_action_pressed("char_undo"):
			current_level.undo()
			moving = true
		elif Input.is_action_just_pressed("char_restart"):
			moving = true
		
	
	else:
		cooldown += delta
		
		if cooldown > cooldown_time:
			cooldown = 0.0
			moving = false
