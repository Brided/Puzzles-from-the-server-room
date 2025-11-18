extends Resource
class_name SokobanStateHistory

var start_state: SokobanGridState
var current_state: SokobanGridState

var history: Array[SokobanGridState] = []
var redo_history: Array[SokobanGridState] = []

func starts(start: SokobanGridState):
	start_state = start.dup()
	history.clear()
	redo_history.clear()

func do(new_state: SokobanGridState):
	history.append(new_state.dup())
	redo_history.clear()

func restart(discard_state: SokobanGridState) -> SokobanGridState:
	redo_history.append(discard_state.dup())
	return start_state.dup()

func undo(discard_state: SokobanGridState) -> SokobanGridState:
	if history.size() > 0:
		redo_history.append(discard_state.dup())
		return history.pop_back().dup()

	return start_state.dup()

func redo() -> SokobanGridState:
	if redo_history.size() > 0:
		var redo_state = redo_history.pop_back()
		history.append(redo_state.dup())
		return redo_state.dup()
	return null
