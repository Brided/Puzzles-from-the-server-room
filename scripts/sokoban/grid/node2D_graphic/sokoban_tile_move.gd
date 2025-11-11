extends Node2D
class_name SokobanTileMove

#var tile_data:= SokobanTile.new()

var real_pos: Vector2

func gen_tile_data() -> SokobanTile:
	return null ## TODO

func _ready(): ## to remove
	tile_data.init_grid_Pos(position)

func _process(delta):
	position = real_pos
	
func update_pos(new_pos: Vector2):
	real_pos = new_pos

func move_z_index(new_z: int):
	z_index = new_z

func move_to(new_grid_pos: SokobanPosition): ## to remove
	tile_data.move_to(new_grid_pos)
