extends SokobanTileMove

class_name TileWall

func _ready():
	super._ready()
	tile_data.change_type("Wall")
	z_index = 1
