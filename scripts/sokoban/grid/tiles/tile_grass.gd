extends SokobanTileMove

class_name TileGrass

func _init():
	tile_data.change_type("Grass")

func _ready():
	z_index = -1
