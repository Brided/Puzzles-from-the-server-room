extends Resource
class_name SokobanGridState

var level_map: Array[SokobanTile] = []
var tiles_by_type: Dictionary[String, SokobanTileList] = {}

var player_facing: Vector2i = Vector2i(0, -1)

func add_Tile(tile: SokobanTile):
	level_map.append(tile)

func replace_Tile(index: int, tile: SokobanTile):
	level_map[index] = tile

func find_all_by_type():
	tiles_by_type.clear()
	for tile in level_map:
		var type_name = tile.type
		if not tiles_by_type.has(type_name):
			tiles_by_type[type_name] = SokobanTileList.new()
		tiles_by_type[type_name].append(tile)

func get_tiles(type_name: String) -> SokobanTileList:
	return tiles_by_type[type_name]

func get_tiles_at_pos(pos: SokobanPosition) -> SokobanTileList:
	var tiles: SokobanTileList = SokobanTileList.new()
	for tile in level_map:
		if pos.equals(tile.grid_pos):
			tiles.append(tile)
	return tiles

func dup() -> SokobanGridState:
	var copy: SokobanGridState = self.duplicate(true)
	
	copy.level_map = []
	for tile in level_map:
		var dup_tile = tile.copy()
		copy.level_map.append(dup_tile)

	copy.tiles_by_type = {}
	for type_name in tiles_by_type.keys():
		copy.tiles_by_type[type_name] = SokobanTileList.new()
		for tile in tiles_by_type[type_name].array:
			var dup_tile = tile.copy()
			copy.tiles_by_type[type_name].append(dup_tile)  # Assuming SokobanTile also has a duplicate method

	return copy

func _to_string():
	var res := ""
	res += "SokobanGridState:\n"
	
	res += "Level Map:\n"
	for tile in level_map:
		res += str(tile) + "\n"

	res += "Tiles by Type:\n"
	for type in tiles_by_type:
		res += "Type: " + type + "\n"
	
	return res
