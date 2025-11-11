extends Node3D

signal toggle_input_signal(state: bool)

func toggle_input(state: bool):
	toggle_input_signal.emit(state)
