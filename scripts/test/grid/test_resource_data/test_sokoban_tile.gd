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

func test_move_blocked_by_wall():
	var grid_state = SokobanGridState.new()
	
	var wall_tile = SokobanTile.new()
	wall_tile.init("Wall", SokobanPosition.new().init_grid(2, 2))
	grid_state.add_Tile(wall_tile)
	
	tile.init("Player", SokobanPosition.new().init_grid(1, 2))
	
	tile.move_dir(Vector2i(1, 0), grid_state) # Move right into wall
	
	assert_eq(tile.grid_pos.pos, Vector2i(1, 2)) # Position should not change

func test_move_push_box():
	var grid_state = SokobanGridState.new()
	
	var box_tile = SokobanTile.new()
	box_tile.init("Box", SokobanPosition.new().init_grid(2, 2))
	grid_state.add_Tile(box_tile)
	
	tile.init("Player", SokobanPosition.new().init_grid(1, 2))
	
	tile.move_dir(Vector2i(1, 0), grid_state) # Move right to push box
	
	assert_eq(tile.grid_pos.pos, Vector2i(2, 2)) # Player should move to box position
	assert_eq(box_tile.grid_pos.pos, Vector2i(3, 2)) # Box should be pushed right

func test_move_push_box_blocked_by_wall():
	var grid_state = SokobanGridState.new()
	
	var box_tile = SokobanTile.new()
	box_tile.init("Box", SokobanPosition.new().init_grid(2, 2))
	grid_state.add_Tile(box_tile)
	
	var wall_tile = SokobanTile.new()
	wall_tile.init("Wall", SokobanPosition.new().init_grid(3, 2))
	grid_state.add_Tile(wall_tile)
	
	tile.init("Player", SokobanPosition.new().init_grid(1, 2))
	
	tile.move_dir(Vector2i(1, 0), grid_state) # Move right to push box blocked by wall
	
	assert_eq(tile.grid_pos.pos, Vector2i(1, 2)) # Player should not move
	assert_eq(box_tile.grid_pos.pos, Vector2i(2, 2)) # Box should not move

func test_move_to():
	var new_pos = SokobanPosition.new().init_grid(6, 7)
	tile.move_to(new_pos)
	
	assert_eq(tile.grid_pos.pos, Vector2i(6, 7))

func test_copy():
	tile.init("Player", SokobanPosition.new().init_grid(1, 1))
	var tile_copy = tile.copy()
	
	assert_eq(tile_copy.type, "Player")
	assert_eq(tile_copy.grid_pos.pos, Vector2i(1, 1))