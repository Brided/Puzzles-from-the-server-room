extends GutTest

var state_history: SokobanStateHistory
var initial_state: SokobanGridState

func before_each():
  state_history = SokobanStateHistory.new()
  initial_state = SokobanGridState.new()

func _create_tile(type: String, x: int, y: int) -> SokobanTile:
  var tile = SokobanTile.new()
  tile.init(type, SokobanPosition.new().init_grid(x, y))
  return tile

func test_starts():
  initial_state.add_Tile(_create_tile("Player", 1, 1))
  state_history.starts(initial_state)
  
  assert_eq(state_history.start_state.level_map.size(), 1)
  assert_eq(state_history.start_state.level_map[0].type, "Player")
  assert_eq(state_history.history.size(), 0)
  assert_eq(state_history.redo_history.size(), 0)

func test_do():
  initial_state.add_Tile(_create_tile("Player", 1, 1))
  state_history.starts(initial_state)
  
  var new_state = SokobanGridState.new()
  new_state.add_Tile(_create_tile("Player", 2, 2))
  state_history.do(new_state)
  
  assert_eq(state_history.history.size(), 1)
  assert_eq(state_history.history[0].level_map[0].grid_pos.pos, Vector2i(1, 1))
  assert_eq(state_history.current_state.level_map[0].grid_pos.pos, Vector2i(2, 2))
  assert_eq(state_history.redo_history.size(), 0)

func test_undo_redo():
  initial_state.add_Tile(_create_tile("Player", 1, 1))
  state_history.starts(initial_state)
  
  var state2 = SokobanGridState.new()
  state2.add_Tile(_create_tile("Player", 2, 2))
  state_history.do(state2)
  
  var state3 = SokobanGridState.new()
  state3.add_Tile(_create_tile("Player", 3, 3))
  state_history.do(state3)
  
  var undo_state = state_history.undo(state_history.current_state)
  assert_eq(undo_state.level_map[0].grid_pos.pos, Vector2i(2, 2))
  assert_eq(state_history.history.size(), 1)
  assert_eq(state_history.redo_history.size(), 1)
  
  var redo_state = state_history.redo()
  assert_eq(redo_state.level_map[0].grid_pos.pos, Vector2i(3, 3))
  assert_eq(state_history.history.size(), 2)
  assert_eq(state_history.redo_history.size(), 0)

func test_restart():
  initial_state.add_Tile(_create_tile("Player", 1, 1))
  state_history.starts(initial_state)
  
  var state2 = SokobanGridState.new()
  state2.add_Tile(_create_tile("Player", 2, 2))
  state_history.do(state2)
  
  var restart_state = state_history.restart(state_history.current_state)
  assert_eq(restart_state.level_map[0].grid_pos.pos, Vector2i(1, 1))
  assert_eq(state_history.redo_history.size(), 1)
  assert_eq(state_history.history.size(), 1)
