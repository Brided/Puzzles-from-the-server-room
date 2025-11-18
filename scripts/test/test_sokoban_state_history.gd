extends GutTest

var history: SokobanStateHistory
var state1: SokobanGridState
var state2: SokobanGridState
var state3: SokobanGridState

func before_each():
	history = SokobanStateHistory.new()
	state1 = create_test_state(Vector2(0, 0))
	state2 = create_test_state(Vector2(1, 0))
	state3 = create_test_state(Vector2(2, 0))

func create_test_state(player_pos: Vector2) -> SokobanGridState:
	var state = SokobanGridState.new()
	var player = SokobanTile.new()
	player.init("Player", SokobanPosition.new().init_grid_vector(player_pos))
	state.add_Tile(player)
	state.find_all_by_type()
	return state

func test_starts():
	history.starts(state1)
	
	assert_eq(history.size(), 1, "Should have initial state")

func test_do():
	history.starts(state1)
	history.do(state2)
	
	assert_eq(history.size(), 2, "Should add new state")

func test_undo():
	history.starts(state1)
	history.do(state2)
	history.do(state3)
	
	var previous = history.undo(state3)
	
	assert_eq(previous.level_map[0].grid_pos.pos, Vector2i(1, 0), "Should return previous state")

func test_undo_at_start():
	history.starts(state1)
	var result = history.undo(state1)
	
	assert_eq(result, state1, "Should return same state when at start")

func test_redo():
	history.starts(state1)
	history.do(state2)
	history.do(state3)
	history.undo(state3)
	
	var next = history.redo()
	
	assert_eq(next.level_map[0].grid_pos.pos, Vector2i(2, 0), "Should return next state")

func test_redo_at_end():
	history.starts(state1)
	history.do(state2)
	
	var result = history.redo()
	
	assert_eq(result, state2, "Should return same state when at end")

func test_restart():
	history.starts(state1)
	history.do(state2)
	history.do(state3)
	
	var first = history.restart(state3)
	
	assert_eq(first.level_map[0].grid_pos.pos, Vector2i(0, 0), "Should return initial state")

func test_do_clears_redo_history():
	history.starts(state1)
	history.do(state2)
	history.do(state3)
	history.undo(state3)  # Now at state2
	
	var new_state = create_test_state(Vector2(5, 5))
	history.do(new_state)  # Should clear state3 from history
	
	var result = history.redo()
	assert_eq(result, new_state, "Should not be able to redo to state3")

func test_size():
	history.starts(state1)
	history.do(state2)
	history.do(state3)
	
	assert_eq(history.size(), 3, "Should return correct history size")
