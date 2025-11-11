extends SokobanTileMove

class_name TileGoal

func _init():
	tile_data.change_type("Goal")

func _ready():
	z_index = 0
