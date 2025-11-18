extends Node2D
class_name SokobanTileMove

var tile_data := SokobanTile.new()
var changed := false
@onready var real_pos:= position

func _ready():
	tile_data.init_from_world_pos(position)

func _process(delta):
	position = lerp(position, real_pos, delta * 10.0)
	
	if changed:
		update()
		changed = false

func update_pos(new_pos: Vector2):
	real_pos = new_pos
	changed = true

func update():
	update_pos(tile_data.grid_pos.to_world_pos())

func move_z_index(new_z: int):
	z_index = new_z

func move_to(new_grid_pos: SokobanPosition):
	tile_data.move_to(new_grid_pos)
