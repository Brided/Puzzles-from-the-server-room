extends Resource
class_name SokobanTile

var grid_pos := SokobanPosition.new().init_grid_vector(Vector2.ZERO)
var type := ""
var moving := false

func init(type_name: String, new_pos: SokobanPosition):
	change_type(type_name)
	init_from_grid_pos(new_pos)

func change_type(change: String):
	type = change

func init_from_world_pos(world_pos: Vector2):
	grid_pos = SokobanPosition.new().init_pos(world_pos)

func init_from_grid_pos(new_pos: SokobanPosition):
	grid_pos = new_pos

func move_dir(direction: Vector2i, grid: SokobanGridState) -> bool:
	var new_grid_pos = grid_pos.add(direction)

	var tiles_at_new_pos = get_tiles_at_pos(new_grid_pos, grid)
	if tiles_at_new_pos.size() > 0:
		print("Tiles at new pos: ", tiles_at_new_pos)
		for tile in tiles_at_new_pos.array:
			if tile.type == "Wall":
				print("Blocked by wall at ", new_grid_pos.pos)
				return false
			elif tile.type == "Box":
				print("Pushing box at ", new_grid_pos.pos)
				if not tile.move_dir(direction, grid):
					return false
	
	grid_pos = new_grid_pos
	return true

func move_to(new_grid_pos: SokobanPosition):
	grid_pos = new_grid_pos

func get_tiles_at_pos(pos: SokobanPosition, grid: SokobanGridState) -> SokobanTileList:
	return grid.get_tiles_at_pos(pos)

func copy() -> SokobanTile:
	var new_tile = SokobanTile.new()
	new_tile.init(type, grid_pos)
	
	return new_tile

func _to_string():
	return type + " " + str(grid_pos)
