extends SokobanTileMove

class_name TileWall

func _init():
	tile_data.change_type("Wall")

func _ready():
	z_index = 1
