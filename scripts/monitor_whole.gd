extends Node3D

var main = load("res://scenes/puzzling/Puzzling.tscn")

signal toggle_input_signal(state: bool)

func toggle_input(state: bool):
	toggle_input_signal.emit(state)
