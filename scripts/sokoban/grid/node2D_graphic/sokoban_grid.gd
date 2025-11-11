extends Node2D
class_name SokobanGrid

const TILE_SIZE = 80

var current_state = SokobanGridState.new()
var state_history = SokobanStateHistory.new()

func _ready():
	state_from_children()
	state_history.starts(current_state)
	print()

func state_from_children():
	for child in get_children():
		if child is SokobanTileMove:
			current_state.add_Tile(child.tile_data)

	current_state.find_all_by_type()

func input(direction: Vector2i):
	var new_state := move_player(direction)
	state_history.do(new_state)
	current_state = new_state
	current_state.update_all()

func undo():
	var last_state := state_history.undo(current_state)
	current_state = last_state

func move_player(direction: Vector2i) -> SokobanGridState:
	var new_state := current_state.duplicate(true)
	var player_tiles := current_state.get_tiles("Player")
	for player: SokobanTile in player_tiles:
		player.move_dir(direction)
	
	return new_state
