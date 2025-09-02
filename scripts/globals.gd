extends Node

const TILE_SIZE = 80
var current_level = 0

var menu_open:= true

signal won

func emit_won():
	won.emit()

func toggle_menu(state: bool):
	menu_open = state
