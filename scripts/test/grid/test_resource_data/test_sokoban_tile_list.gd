extends GutTest

var tile_list: SokobanTileList

func before_each():
  tile_list = SokobanTileList.new()

func test_append_and_size():
  var tile1 = SokobanTile.new()
  tile1.init("Box", SokobanPosition.new().init_grid(1, 1))
  tile_list.append(tile1)
  
  var tile2 = SokobanTile.new()
  tile2.init("Wall", SokobanPosition.new().init_grid(2, 2))
  tile_list.append(tile2)
  
  assert_eq(tile_list.size(), 2)

func test_remove_tile():
  var tile1 = SokobanTile.new()
  tile1.init("Box", SokobanPosition.new().init_grid(1, 1))
  tile_list.append(tile1)
  
  var tile2 = SokobanTile.new()
  tile2.init("Wall", SokobanPosition.new().init_grid(2, 2))
  tile_list.append(tile2)
  
  var removed = tile_list.remove_tile(tile1)
  assert_eq(removed, true)
  assert_eq(tile_list.size(), 1)
  
  var not_removed = tile_list.remove_tile(tile1)
  assert_eq(not_removed, false)
  assert_eq(tile_list.size(), 1)

func test_get_tile():
  var tile1 = SokobanTile.new()
  tile1.init("Box", SokobanPosition.new().init_grid(1, 1))
  tile_list.append(tile1)
  
  var retrieved_tile = tile_list.get_tile(0)
  assert_eq(retrieved_tile.type, "Box")
  assert_eq(retrieved_tile.grid_pos.pos, Vector2i(1, 1))

func test_get_all_tiles():
  var tile1 = SokobanTile.new()
  tile1.init("Box", SokobanPosition.new().init_grid(1, 1))
  tile_list.append(tile1)
  var tile2 = SokobanTile.new()
  tile2.init("Wall", SokobanPosition.new().init_grid(2, 2))
  tile_list.append(tile2)
  
  var all_tiles = tile_list.get_all_tiles()
  assert_eq(all_tiles.size(), 2)
  assert_eq(all_tiles[0].type, "Box")
  assert_eq(all_tiles[1].type, "Wall")

func test_clear():
  var tile1 = SokobanTile.new()
  tile1.init("Box", SokobanPosition.new().init_grid(1, 1))
  tile_list.append(tile1)
  var tile2 = SokobanTile.new()
  tile2.init("Wall", SokobanPosition.new().init_grid(2, 2))
  tile_list.append(tile2)
  
  tile_list.clear()
  assert_eq(tile_list.size(), 0)

func test_find_by_type():
  var tile1 = SokobanTile.new()
  tile1.init("Box", SokobanPosition.new().init_grid(1, 1))
  tile_list.append(tile1)
  var tile2 = SokobanTile.new()
  tile2.init("Wall", SokobanPosition.new().init_grid(2, 2))
  tile_list.append(tile2)
  var tile3 = SokobanTile.new()
  tile3.init("Box", SokobanPosition.new().init_grid(3, 3))
  tile_list.append(tile3)
  
  var box_tiles = tile_list.find_by_type("Box")
  assert_eq(box_tiles.size(), 2)
  assert_eq(box_tiles[0].grid_pos.pos, Vector2i(1, 1))
  assert_eq(box_tiles[1].grid_pos.pos, Vector2i(3, 3))
  
  var wall_tiles = tile_list.find_by_type("Wall")
  assert_eq(wall_tiles.size(), 1)
  assert_eq(wall_tiles[0].grid_pos.pos, Vector2i(2, 2))