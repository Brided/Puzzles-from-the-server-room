extends GutTest

var position: SokobanPosition

func before_each():
  position = SokobanPosition.new()

func test_init_grid():
  position.init_grid(3, 4)
  assert_eq(position.pos, Vector2i(3, 4))

func test_init_grid_vector():
  position.init_grid_vector(Vector2i(5, 6))
  assert_eq(position.pos, Vector2i(5, 6))

func test_init_pos():
  var world_pos = Vector2(2*80, 3*80) # Assuming TILE_SIZE is 80
  position.init_pos(world_pos)
  assert_eq(position.pos, Vector2i(2, 3))

func test_to_world_pos():
  position.init_grid(4, 5)
  var world_pos = position.to_world_pos()
  assert_eq(world_pos, Vector2(4*80, 5*80)) # Assuming TILE_SIZE is 80

func test_add():
  position.init_grid(1, 1)
  var new_position = position.add(Vector2i(2, 3))
  assert_eq(new_position.pos, Vector2i(3, 4))

func test_equals():
  position.init_grid(2, 2)
  var other_position = SokobanPosition.new().init_grid(2, 2)
  assert_eq(position.equals(other_position), true)

func test_not_equals():
  position.init_grid(2, 2)
  var other_position = SokobanPosition.new().init_grid(3, 3)
  assert_eq(position.equals(other_position), false)