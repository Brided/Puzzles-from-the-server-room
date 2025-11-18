extends GutTest

var tile_list: SokobanTileList

func before_each():
    tile_list = SokobanTileList.new()

func test_append():
    var tile = SokobanTile.new()
    tile.init("Player", SokobanPosition.new().init_grid_vector(Vector2(1, 1)))
    
    tile_list.append(tile)
    
    assert_eq(tile_list.size(), 1, "Should have 1 tile")
    assert_eq(tile_list.array[0], tile, "Should contain the tile")

func test_remove_tile():
    var tile1 = SokobanTile.new()
    tile1.init("Player", SokobanPosition.new().init_grid_vector(Vector2(1, 1)))
    var tile2 = SokobanTile.new()
    tile2.init("Box", SokobanPosition.new().init_grid_vector(Vector2(2, 2)))
    
    tile_list.append(tile1)
    tile_list.append(tile2)
    
    var removed = tile_list.remove_tile(tile1)
    
    assert_true(removed, "Should return true when tile removed")
    assert_eq(tile_list.size(), 1, "Should have 1 tile left")
    assert_eq(tile_list.array[0], tile2, "Should contain tile2")

func test_remove_tile_not_found():
    var tile = SokobanTile.new()
    var removed = tile_list.remove_tile(tile)
    
    assert_false(removed, "Should return false when tile not found")

func test_get_tile():
    var tile = SokobanTile.new()
    tile.init("Wall", SokobanPosition.new().init_grid_vector(Vector2(3, 3)))
    tile_list.append(tile)
    
    var retrieved = tile_list.get_tile(0)
    
    assert_eq(retrieved, tile, "Should get correct tile by index")

func test_get_tile_out_of_bounds():
    var retrieved = tile_list.get_tile(5)
    assert_null(retrieved, "Should return null for out of bounds index")

func test_get_all_tiles():
    var tile1 = SokobanTile.new()
    var tile2 = SokobanTile.new()
    tile_list.append(tile1)
    tile_list.append(tile2)
    
    var all_tiles = tile_list.get_all_tiles()
    
    assert_eq(all_tiles.size(), 2, "Should return all tiles")
    assert_ne(all_tiles, tile_list.array, "Should return a copy")

func test_clear():
    tile_list.append(SokobanTile.new())
    tile_list.append(SokobanTile.new())
    tile_list.clear()
    
    assert_eq(tile_list.size(), 0, "Should clear all tiles")

func test_count():
    tile_list.append(SokobanTile.new())
    tile_list.append(SokobanTile.new())
    
    assert_eq(tile_list.count(), 2, "Should return correct count")

func test_find_by_type():
    var player = SokobanTile.new()
    player.init("Player", SokobanPosition.new().init_grid_vector(Vector2(1, 1)))
    var box1 = SokobanTile.new()
    box1.init("Box", SokobanPosition.new().init_grid_vector(Vector2(2, 2)))
    var box2 = SokobanTile.new()
    box2.init("Box", SokobanPosition.new().init_grid_vector(Vector2(3, 3)))
    
    tile_list.append(player)
    tile_list.append(box1)
    tile_list.append(box2)
    
    var boxes = tile_list.find_by_type("Box")
    
    assert_eq(boxes.size(), 2, "Should find 2 boxes")
    assert_has(boxes, box1, "Should contain box1")
    assert_has(boxes, box2, "Should contain box2")