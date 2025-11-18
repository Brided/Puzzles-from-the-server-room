extends SokobanTileMove

class_name TileGoal

func _ready():
	super._ready()
	tile_data.change_type("Goal")
	z_index = 0
