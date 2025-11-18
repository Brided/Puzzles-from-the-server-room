extends Node2D
class_name SokobanGrid

const TILE_SIZE = 80

@onready var current_state = SokobanGridState.new()
@onready var state_history = SokobanStateHistory.new()

@onready var node_list := get_children().filter(func(c): return c is SokobanTileMove)

func _ready():
	state_from_children()
	state_history.starts(current_state)

func state_from_children():
	for child in node_list:
		var tile_move = child as SokobanTileMove
		var new_tile = tile_move.tile_data.copy()
		
		current_state.add_Tile(new_tile)

	current_state.find_all_by_type()

func find_node_by_tile(tile: SokobanTile) -> SokobanTileMove:
	for child in node_list:
		var tile_move = child as SokobanTileMove
		## if type and grid_pos match
		if tile_move.tile_data.type == tile.type\
		and tile_move.tile_data.grid_pos == tile.grid_pos:
			return tile_move
	return null

func input(direction: Vector2i):
	var new_state := move_player(direction)
	state_history.do(new_state)
	current_state = new_state
	load_state(new_state)
	
func undo():
	var last_state := state_history.undo(current_state)
	current_state = last_state
	load_state(last_state)

func restart():
	var first_state := state_history.restart(current_state)
	current_state = first_state
	load_state(first_state)

func load_state(state: SokobanGridState):
	var visual_tiles = get_children().filter(func(c): return c is SokobanTileMove)
	for i in range(min(visual_tiles.size(), state.level_map.size())):
		var visual_node = visual_tiles[i] as SokobanTileMove
		var data_tile = state.level_map[i]

		visual_node.tile_data = data_tile
		visual_node.update()
		
		if data_tile.type == "Player":
			var player_node = visual_node as SokobanPlayer
			player_node.set_anim(state.player_facing)

func move_player(direction: Vector2i) -> SokobanGridState:
	var new_state := current_state.dup()
	new_state.player_facing = direction
	var player_tiles := new_state.get_tiles("Player")  # Get from NEW state
	
	for player: SokobanTile in player_tiles.array:
		print("Moving player at ", player.grid_pos.pos, " direction ", direction)
		var target_tile = find_node_by_tile(player) as SokobanPlayer
		
		if target_tile:
			player.move_dir(direction, new_state)
			new_state.replace_Tile(new_state.level_map.find(player), player)

	return new_state
