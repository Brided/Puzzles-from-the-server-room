extends Node2D
class_name Pushing

@warning_ignore("integer_division")

@onready var sokoban_grid_state := SokobanGridState.new()
var grid_size := SokobanGrid.TILE_SIZE

const LVL_001:= "res://scenes/puzzling/levels/lvl-001.txt"
const LVL_002:= "res://scenes/puzzling/levels/lvl-002.txt"
const LVL_LIST:= [LVL_001, LVL_002]
var cur_lvl:= -1

var level_map = {} # dictionary storing positions of walls/boxes/goals
var boxes = []
var goals = []

var state_history = []
var cur_state: Dictionary
var start_state: Dictionary

var player_pos: Vector2
var move_dir: String

@onready var player = $LevelLoader/MainSokoChar
@onready var camera:= $Camera2D

# ACTIVE

var is_active:= true

func set_active(state: bool):
	is_active = state
	set_process(state)
	set_process_input(state)

# LOADING

# Called when the node enters the scene tree for the first time.
func _ready():
	new_level()

func center_camera_on_level(level_width: int, level_height: int):
	@warning_ignore("integer_division")
	var center_x = ((level_width - 1) * Globals.TILE_SIZE) / 2
	@warning_ignore("integer_division")
	var center_y = ((level_height - 1) * Globals.TILE_SIZE) / 2
	camera.position = Vector2(center_x, center_y)

func new_level():
	cur_lvl = (cur_lvl + 1) % LVL_LIST.size()
	var level_location = LVL_LIST[cur_lvl]
	
	state_history.clear()
	boxes.clear()
	goals.clear()
	level_map.clear()
	player.set_anim("down")
	
	var dims = load_level(level_location)
	start_state = {"boxes": boxes.duplicate(true), "player": player_pos, "dir": "down"}
	cur_state = start_state
	
	center_camera_on_level(dims.width, dims.height)

func load_level(path: String) -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Could not open file: " + path)
		return {}

	var lines: Array[String] = []
	while not file.eof_reached():
		var line = file.get_line()
		if line.strip_edges() != "": # skip empty lines
			lines.append(line)

	file.close()

	var height = lines.size()
	var width = 0
	for line in lines:
		width = max(width, line.length())
	
	$LevelLoader.despawn_all()
	$LevelLoader.load_level(path, self)
	
	return {
		"lines": lines,
		"width": width,
		"height": height
	}

# PLAYING

var cooldown_time: float = 0.14
var cooldown: float = 0.0
var moving: bool

var restarted: bool

func _process(delta):
	if !is_active:
		return
	
	if !moving:
		if Input.is_action_pressed("char_up"):
			move_dir = "up"
			try_move(Vector2.UP)
		elif Input.is_action_pressed("char_down"):
			move_dir = "down"
			try_move(Vector2.DOWN)
		elif Input.is_action_pressed("char_left"):
			move_dir = "left"
			try_move(Vector2.LEFT)
		elif Input.is_action_pressed("char_right"):
			move_dir = "right"
			try_move(Vector2.RIGHT)
			
		elif Input.is_action_pressed("char_undo"):
			undo()
		elif Input.is_action_just_pressed("char_restart"):
			restart()
	
	else:
		cooldown += delta
		
		if cooldown > cooldown_time:
			cooldown = 0.0
			moving = false

func try_move(dir: Vector2):
	var new_pos = player_pos + dir
	if is_wall(new_pos):
		return

	if is_box(new_pos):
		var box_new = new_pos + dir
		if is_free(box_new):
			move_box(new_pos, box_new)
			move_player(new_pos)
	elif is_free(new_pos):
		move_player(new_pos)

func is_wall(pos: Vector2) -> bool:
	return str(pos) in level_map and level_map[str(pos)] == "#"

func is_box(pos: Vector2) -> bool:
	for box in boxes:
		if box["pos"] == pos:
			return true
	return false

func is_free(pos: Vector2) -> bool:
	return not is_wall(pos) and not is_box(pos)

func move_player(new_pos: Vector2):
	moving = true
	
	player_pos = new_pos
	player.move_player(new_pos)
	player.set_anim(move_dir)
	
	add_state()
	
	if test_win():
		Globals.emit_won()
		new_level()

func move_box_at(new_pos: Vector2, i: int):
	var box = boxes[i]
	box["pos"] = new_pos
	box["node"].position = new_pos * grid_size

func move_box(old_pos: Vector2, new_pos: Vector2):
	for box in boxes:
		if box["pos"] == old_pos:
			box["pos"] = new_pos
			box["node"].position = new_pos * grid_size

func undo():
	if state_history.size() > 1:
		cur_state = state_history.pop_back()
		if cur_state != null:
			load_State(cur_state)
	else:
		cur_state = start_state
		load_State(cur_state)
	
	moving = true

func restart():
	add_state()
	cur_state = start_state
	load_State(cur_state)
	
	moving = true

func add_state():
	state_history.append(cur_state)
	cur_state = {"boxes": boxes.duplicate(true), "player": player_pos, "dir": move_dir}

func load_State(stateTarget):
	print(stateTarget)
	for ib in range(stateTarget["boxes"].size()):
		move_box_at(stateTarget["boxes"][ib]["pos"], ib)
	
	player_pos = stateTarget["player"]
	player.move_player(player_pos)
	player.set_anim(stateTarget["dir"])

func test_win() -> bool:
	var box_posses := []
	for b in boxes:
		box_posses.append(b.pos)
	
	for g in goals:
		if not box_posses.has(g.pos):
			return false
	
	return true

func _on_monitor_toggle_input_signal(state):
	set_active(state)
