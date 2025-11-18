extends SokobanTileMove

class_name TileGrass

func _ready():
	super._ready()
	tile_data.change_type("Grass")
	z_index = -1
