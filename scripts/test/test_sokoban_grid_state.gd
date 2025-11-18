extends GutTest

var grid_state: SokobanGridState

func before_each():
    grid_state = SokobanGridState.new()

func test_add_tile():
    var tile = SokobanTile.new()
    tile.init("Player", SokobanPosition.new().init_grid_vector(Vector2(1, 1)))
    
    grid_state.add_Tile(tile)
    
    assert_eq(grid_state.level_map.size(), 1, "Should add tile to level_map")

func test_replace_tile():
    var tile1 = SokobanTile.new()
    tile1.init("Box", SokobanPosition.new().init_grid_vector(Vector2(1, 1)))
    var tile2 = SokobanTile.new()
    tile2.init("Player", SokobanPosition.new().init_grid_vector(Vector2(2, 2)))
    
    grid_state.add_Tile(tile1)
    grid_state.replace_Tile(0, tile2)
    
    assert_eq(grid_state.level_map[0], tile2, "Should replace tile at index")

func test_find_all_by_type():
    var player = SokobanTile.new()
    player.init("Player", SokobanPosition.new().init_grid_vector(Vector2(1, 1)))
    var box1 = SokobanTile.new()
    box1.init("Box", SokobanPosition.new().init_grid_vector(Vector2(2, 2)))
    var box2 = SokobanTile.new()
    box2.init("Box", SokobanPosition.new().init_grid_vector(Vector2(3, 3)))
    
    grid_state.add_Tile(player)
    grid_state.add_Tile(box1)
    grid_state.add_Tile(box2)
    grid_state.find_all_by_type()
    
    assert_true(grid_state.tiles_by_type.has("Player"), "Should have Player type")
    assert_true(grid_state.tiles_by_type.has("Box"), "Should have Box type")
    assert_eq(grid_state.tiles_by_type["Box"].size(), 2, "Should have 2 boxes")

func test_get_tiles():
    var wall = SokobanTile.new()
    wall.init("Wall", SokobanPosition.new().init_grid_vector(Vector2(0, 0)))
    grid_state.add_Tile(wall)
    grid_state.find_all_by_type()
    
    var walls = grid_state.get_tiles("Wall")
    
    assert_eq(walls.size(), 1, "Should get tiles by type")
    assert_eq(walls.array[0], wall, "Should contain the wall")

func test_get_tiles_at_pos():
    var pos = SokobanPosition.new().init_grid_vector(Vector2(5, 5))
    var tile1 = SokobanTile.new()
    tile1.init("Box", pos)
    var tile2 = SokobanTile.new()
    tile2.init("Goal", pos)
    
    grid_state.add_Tile(tile1)
    grid_state.add_Tile(tile2)
    
    var tiles = grid_state.get_tiles_at_pos(pos)
    
    assert_eq(tiles.size(), 2, "Should find 2 tiles at position")

func test_get_tiles_at_pos_empty():
    var pos = SokobanPosition.new().init_grid_vector(Vector2(10, 10))
    var tiles = grid_state.get_tiles_at_pos(pos)
    
    assert_eq(tiles.size(), 0, "Should return empty list for empty position")

func test_dup():
    var player = SokobanTile.new()
    player.init("Player", SokobanPosition.new().init_grid_vector(Vector2(1, 1)))
    grid_state.add_Tile(player)
    grid_state.find_all_by_type()
    grid_state.player_facing = Vector2i.RIGHT
    
    var copy = grid_state.dup()
    
    assert_ne(copy, grid_state, "Duplicate should be different instance")
    assert_eq(copy.level_map.size(), 1, "Duplicate should have same tile count")
    assert_eq(copy.player_facing, Vector2i.RIGHT, "Duplicate should copy player_facing")
    assert_ne(copy.level_map[0], grid_state.level_map[0], "Tiles should be copied, not referenced")

func test_player_facing():
    grid_state.player_facing = Vector2i.UP
    assert_eq(grid_state.player_facing, Vector2i.UP, "Should store player facing direction")