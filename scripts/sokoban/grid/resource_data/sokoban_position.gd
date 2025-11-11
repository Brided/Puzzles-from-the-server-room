extends Resource
class_name SokobanPosition

var pos: Vector2i = Vector2i.ZERO # coordinates in the grid
const TILE_SIZE = SokobanGrid.TILE_SIZE

## Init with grid_pos as Vector2
func init_grid_vector(grid_pos: Vector2i) -> SokobanPosition:
	pos = grid_pos
	return self

## Init with x, y grid_pos as Vector2
func init_grid(x: int, y: int) -> SokobanPosition:
	var grid_pos = Vector2i(x, y)
	return self.init_grid_vector(grid_pos)

## Init with world_pos as Vector2
func init_pos(world_pos: Vector2) -> SokobanPosition:
	pos = world_to_grid(world_pos)
	return self
	
func to_world_pos() -> Vector2:
	return grid_to_world(pos)

# Convert a grid coordinate to a world position
func grid_to_world(grid_pos: Vector2i) -> Vector2:
	return grid_pos * TILE_SIZE

# Convert a world position to a grid coordinate 
func world_to_grid(world_pos: Vector2) -> Vector2i:
	return Vector2i(world_pos / TILE_SIZE)

func add(added: Vector2i) -> SokobanPosition:
	var new_pos = pos + added
	return SokobanPosition.new().init_grid_vector(new_pos)

func _to_string() -> String:
	return str(pos) + " " + str(self.to_world_pos())
