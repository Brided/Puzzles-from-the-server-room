extends Resource
class_name SokobanTileList

var array: Array[SokobanTile] = []  # Initialize the array

# Add a tile to the list
func append(tile: SokobanTile):
	array.append(tile)

# Remove a tile from the list
func remove_tile(tile: SokobanTile) -> bool:
	if array.has(tile):
		array.erase(tile)
		return true
	return false

func size() -> int:
	return array.size()

# Get a tile by index
func get_tile(index: int) -> SokobanTile:
	if index >= 0 and index < array.size():
		return array[index]
	return null  # Return null if index is out of bounds

# Get all tiles
func get_all_tiles() -> Array[SokobanTile]:
	return array.duplicate()  # Return a copy of the array

# Clear all tiles
func clear():
	array.clear()

# Count the number of tiles
func count() -> int:
	return array.size()

# Find a tile by type
func find_by_type(type_name: String) -> Array[SokobanTile]:
	var result: Array[SokobanTile] = []
	for tile in array:
		if tile.type == type_name:
			result.append(tile)
	return result
