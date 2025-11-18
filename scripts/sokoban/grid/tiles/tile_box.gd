extends SokobanTileMove

class_name TileBox

func _ready():
	super._ready()
	tile_data.change_type("Box")
	z_index = 0

func on_push(direction: Vector2):
	move_to(tile_data.grid_pos.add(direction))
