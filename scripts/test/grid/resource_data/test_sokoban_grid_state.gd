extends GutTest

var grid_state: SokobanGridState
var tile: SokobanTile

func before_each():
	grid_state = SokobanGridState.new()
	tile = SokobanTile.new()

func test_add_tile():
	tile.init("Box", SokobanPosition.new().init_grid(1, 1))
	grid_state.add_Tile(tile)
 	
	assert_eq(grid_state.level_map.size(), 1)
	assert_eq(grid_state.level_map[0].type, "Box")
	assert_eq(grid_state.level_map[0].grid_pos.pos, Vector2i(1, 1))

func test_replace_tile():
	tile.init("Box", SokobanPosition.new().init_grid(1, 1))
	grid_state.add_Tile(tile)
	
	var new_tile = SokobanTile.new()
	new_tile.init("Wall", SokobanPosition.new().init_grid(2, 2))
	grid_state.replace_Tile(0, new_tile)
	
	assert_eq(grid_state.level_map.size(), 1)
	assert_eq(grid_state.level_map[0].type, "Wall")
	assert_eq(grid_state.level_map[0].grid_pos.pos, Vector2i(2, 2))

func test_find_all_by_type():
	var box_tile = SokobanTile.new()
	box_tile.init("Box", SokobanPosition.new().init_grid(1, 1))
	var wall_tile = SokobanTile.new()
	wall_tile.init("Wall", SokobanPosition.new().init_grid(2, 2))
	var another_box_tile = SokobanTile.new()
	another_box_tile.init("Box", SokobanPosition.new().init_grid(3, 3))
	
	grid_state.add_Tile(box_tile)
	grid_state.add_Tile(wall_tile)
	grid_state.add_Tile(another_box_tile)
	grid_state.find_all_by_type()
	
	assert_eq(grid_state.tiles_by_type.size(), 2)
	assert_eq(grid_state.tiles_by_type["Box"].size(), 2)
	assert_eq(grid_state.tiles_by_type["Wall"].size(), 1)
	
	assert_eq(grid_state.tiles_by_type["Box"].array[0].grid_pos.pos, Vector2i(1, 1))
	assert_eq(grid_state.tiles_by_type["Box"].array[1].grid_pos.pos, Vector2i(3, 3))
	assert_eq(grid_state.tiles_by_type["Wall"].array[0].grid_pos.pos, Vector2i(2, 2))

func test_get_tiles():
	var box_tile = SokobanTile.new()
	box_tile.init("Box", SokobanPosition.new().init_grid(1, 1))
	var wall_tile = SokobanTile.new()
	wall_tile.init("Wall", SokobanPosition.new().init_grid(2, 2))
	
	grid_state.add_Tile(box_tile)
	grid_state.add_Tile(wall_tile)
	grid_state.find_all_by_type()
	
	var box_tiles = grid_state.get_tiles("Box")
	assert_eq(box_tiles.size(), 1)
	assert_eq(box_tiles.array[0].grid_pos.pos, Vector2i(1, 1))
	
	var wall_tiles = grid_state.get_tiles("Wall")
	assert_eq(wall_tiles.size(), 1)
	assert_eq(wall_tiles.array[0].grid_pos.pos, Vector2i(2, 2))

func test_get_tiles_at_pos():
	var box_tile = SokobanTile.new()
	box_tile.init("Box", SokobanPosition.new().init_grid(1, 1))
	var wall_tile = SokobanTile.new()
	wall_tile.init("Wall", SokobanPosition.new().init_grid(1, 1))
	var player_tile = SokobanTile.new()
	player_tile.init("Player", SokobanPosition.new().init_grid(2, 2))
	
	grid_state.add_Tile(box_tile)
	grid_state.add_Tile(wall_tile)
	grid_state.add_Tile(player_tile)
	
	var tiles_at_1_1 = grid_state.get_tiles_at_pos(SokobanPosition.new().init_grid(1, 1))
	assert_eq(tiles_at_1_1.size(), 2)
	
	var tiles_at_2_2 = grid_state.get_tiles_at_pos(SokobanPosition.new().init_grid(2, 2))
	assert_eq(tiles_at_2_2.size(), 1)
	assert_eq(tiles_at_2_2.array[0].type, "Player")

func test_dup():
	var box_tile = SokobanTile.new()
	box_tile.init("Box", SokobanPosition.new().init_grid(1, 1))
	grid_state.add_Tile(box_tile)
	grid_state.find_all_by_type()
	
	var dup_state = grid_state.dup()
	assert_eq(dup_state.level_map.size(), 1)
	assert_eq(dup_state.level_map[0].type, "Box")
	assert_eq(dup_state.level_map[0].grid_pos.pos, Vector2i(1, 1))

func test_to_string():
	var box_tile = SokobanTile.new()
	box_tile.init("Box", SokobanPosition.new().init_grid(1, 1))
	var wall_tile = SokobanTile.new()
	wall_tile.init("Wall", SokobanPosition.new().init_grid(2, 2))
	
	grid_state.add_Tile(box_tile)
	grid_state.add_Tile(wall_tile)
	grid_state.find_all_by_type()
	
	var res = grid_state._to_string()
	print_debug(res)
	assert_eq(
		res == "Box (1, 1) (80.0, 80.0)\nWall (2, 2) (160.0, 160.0)\n"\
		or res == "Wall (2, 2) (160.0, 160.0)\nBox (1, 1) (80.0, 80.0)\n", true)