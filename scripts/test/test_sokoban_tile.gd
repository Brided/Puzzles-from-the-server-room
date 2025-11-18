extends GutTest

var tile: SokobanTile
var grid_state: SokobanGridState

func before_each():
    tile = SokobanTile.new()
    grid_state = SokobanGridState.new()

func test_init():
    var pos = SokobanPosition.new().init_grid_vector(Vector2(2, 3))
    tile.init("Player", pos)
    
    assert_eq(tile.type, "Player", "Should set type")
    assert_eq(tile.grid_pos.pos, Vector2i(2, 3), "Should set position")

func test_change_type():
    tile.change_type("Box")
    assert_eq(tile.type, "Box", "Should change type")

func test_init_from_world_pos():
    tile.init_from_world_pos(Vector2(160, 240))
    assert_eq(tile.grid_pos.pos, Vector2i(2, 3), "Should init from world position")

func test_init_from_grid_pos():
    var pos = SokobanPosition.new().init_grid_vector(Vector2(5, 5))
    tile.init_from_grid_pos(pos)
    assert_eq(tile.grid_pos.pos, Vector2i(5, 5), "Should init from grid position")

func test_move_to():
    var new_pos = SokobanPosition.new().init_grid_vector(Vector2(3, 4))
    tile.move_to(new_pos)
    assert_eq(tile.grid_pos.pos, Vector2i(3, 4), "Should move to new position")

func test_move_dir_empty_space():
    tile.init("Player", SokobanPosition.new().init_grid_vector(Vector2(1, 1)))
    tile.move_dir(Vector2i.RIGHT, grid_state)
    
    assert_eq(tile.grid_pos.pos, Vector2i(2, 1), "Should move right into empty space")

func test_move_dir_blocked_by_wall():
    # Setup: Player at (1,1), Wall at (2,1)
    tile.init("Player", SokobanPosition.new().init_grid_vector(Vector2(1, 1)))
    var wall = SokobanTile.new()
    wall.init("Wall", SokobanPosition.new().init_grid_vector(Vector2(2, 1)))
    
    grid_state.add_Tile(tile)
    grid_state.add_Tile(wall)
    grid_state.find_all_by_type()
    
    tile.move_dir(Vector2i.RIGHT, grid_state)
    
    assert_eq(tile.grid_pos.pos, Vector2i(1, 1), "Should not move through wall")

func test_move_dir_push_box():
    # Setup: Player at (1,1), Box at (2,1), empty at (3,1)
    tile.init("Player", SokobanPosition.new().init_grid_vector(Vector2(1, 1)))
    var box = SokobanTile.new()
    box.init("Box", SokobanPosition.new().init_grid_vector(Vector2(2, 1)))
    
    grid_state.add_Tile(tile)
    grid_state.add_Tile(box)
    grid_state.find_all_by_type()
    
    tile.move_dir(Vector2i.RIGHT, grid_state)
    
    assert_eq(tile.grid_pos.pos, Vector2i(2, 1), "Player should move to box position")
    assert_eq(box.grid_pos.pos, Vector2i(3, 1), "Box should be pushed")

func test_copy():
    tile.init("Box", SokobanPosition.new().init_grid_vector(Vector2(3, 3)))
    var copy = tile.copy()
    
    assert_eq(copy.type, "Box", "Copy should have same type")
    assert_eq(copy.grid_pos.pos, Vector2i(3, 3), "Copy should have same position")
    assert_ne(copy, tile, "Copy should be different instance")

func test_to_string():
    tile.init("Player", SokobanPosition.new().init_grid_vector(Vector2(2, 3)))
    var string_rep = str(tile)
    
    assert_string_contains(string_rep, "Player", "String should contain type")
    assert_string_contains(string_rep, "2", "String should contain x position")
    assert_string_contains(string_rep, "3", "String should contain y position")