extends GutTest

var position: SokobanPosition

func before_each():
    position = SokobanPosition.new()

func test_init_grid_vector():
    position.init_grid_vector(Vector2(2, 3))
    assert_eq(position.pos, Vector2i(2, 3), "Should initialize with Vector2")

func test_init_pos_from_world():
    # Assuming TILE_SIZE = 80
    position.init_pos(Vector2(160, 240))
    assert_eq(position.pos, Vector2i(2, 3), "Should convert world pos to grid pos")

func test_add_direction():
    position.init_grid_vector(Vector2(1, 1))
    var new_pos = position.add(Vector2i(1, 0))
    
    assert_eq(new_pos.pos, Vector2i(2, 1), "Should add direction correctly")
    assert_eq(position.pos, Vector2i(1, 1), "Original position should not change")

func test_to_world_pos():
    position.init_grid_vector(Vector2(2, 3))
    var world_pos = position.to_world_pos()
    
    # Assuming TILE_SIZE = 80
    assert_eq(world_pos, Vector2(160, 240), "Should convert grid to world pos")

func test_equals():
    position.init_grid_vector(Vector2(2, 3))
    var other = SokobanPosition.new().init_grid_vector(Vector2(2, 3))
    var different = SokobanPosition.new().init_grid_vector(Vector2(1, 1))
    
    assert_true(position.equals(other), "Same positions should be equal")
    assert_false(position.equals(different), "Different positions should not be equal")

func test_duplicate():
    position.init_grid_vector(Vector2(5, 7))
    var dup_pos = position.duplicate(true)
    
    assert_eq(dup_pos.pos, position.pos, "Duplicate should have same position")
    assert_ne(dup_pos, position, "Duplicate should be a different instance")