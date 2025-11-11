extends Resource
class_name SokobanGridState

var level_map: Array[SokobanTile] = []
var tiles_by_type: Dictionary = {}

func add_Tile(tile: SokobanTile):
	level_map.append(tile)

func find_all_by_type():
	tiles_by_type.clear()
	for tile in level_map:
		var type_name = tile.type
		if not tiles_by_type.has(type_name):
			tiles_by_type[type_name] = []
		tiles_by_type[type_name].append(tile)

func get_tiles(type_name: String) -> Array:
	return tiles_by_type.get(type_name, [])

func update_all():
	for tile in level_map:
		tile.update_pos()

func dup() -> SokobanGridState:
	var copy: SokobanGridState = duplicate(true)
	copy.find_all_by_type()
	return copy

func _to_string():
	var res := ""
	for tile in level_map:
		res += str(tile) + "\n"
	for type in tiles_by_type:
		print(type, tiles_by_type[type])
		
	return res
