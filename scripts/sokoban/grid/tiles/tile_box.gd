extends SokobanTileMove

class_name TileBox

func _init():
	tile_data.change_type("Box")

func _ready():
	z_index = 0

func on_push(direction: Vector2):
	move_to(tile_data.grid_pos.add(direction))
