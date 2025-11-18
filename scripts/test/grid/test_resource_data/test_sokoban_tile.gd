extends GutTest

var tile: SokobanTile

func before_each():
	tile = SokobanTile.new()

func test_init_tile():
	var pos = SokobanPosition.new().init_grid(2, 3)
	tile.init("Box", pos)
	
	assert_eq(tile.type, "Box")
	assert_eq(tile.grid_pos.pos, Vector2i(2, 3))

func test_change_type():
	tile.change_type("Wall")
	
	assert_eq(tile.type, "Wall")

func test_init_from_world_pos():
	var world_pos = Vector2(2*80, 3*80) # Assuming each tile is 80x80
	tile.init_from_world_pos(world_pos)
	
	assert_eq(tile.grid_pos.pos, Vector2i(2, 3))

func test_init_from_grid_pos():
	var pos = SokobanPosition.new().init_grid(4, 5)
	tile.init_from_grid_pos(pos)
	
	assert_eq(tile.grid_pos.pos, Vector2i(4, 5))

func test_move_to():
	var new_pos = SokobanPosition.new().init_grid(6, 7)
	tile.move_to(new_pos)
	
	assert_eq(tile.grid_pos.pos, Vector2i(6, 7))

func test_copy():
	tile.init("Player", SokobanPosition.new().init_grid(1, 1))
	var tile_copy = tile.copy()
	
	assert_eq(tile_copy.type, "Player")
	assert_eq(tile_copy.grid_pos.pos, Vector2i(1, 1))

func test_to_string():
	tile.init("Box", SokobanPosition.new().init_grid(2, 3))
	
	var res = tile._to_string()
	print_debug(res)
	assert_eq(res, "Box (2, 3) (160.0, 240.0)")