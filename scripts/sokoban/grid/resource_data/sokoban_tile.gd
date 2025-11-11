extends Resource
class_name SokobanTile

var grid_pos := SokobanPosition.new().init_grid_vector(Vector2.ZERO)
var type := ""
var moving := false

func move_dir(direction: Vector2i):
	grid_pos = grid_pos.add(direction)

func change_type(change: String):
	type = change

func move_to(new_grid_pos: SokobanPosition):
	grid_pos = new_grid_pos
	print(new_grid_pos)

func init_grid_Pos(world_pos: Vector2):
	grid_pos = SokobanPosition.new().init_pos(world_pos)

func _to_string():
	return type + " " + str(grid_pos)
