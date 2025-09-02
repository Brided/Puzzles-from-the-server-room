extends CanvasLayer

@onready var menu = $MenuUI

func _ready():
	Globals.won.connect(Callable(self, "_on_win"))
	menu.visible = Globals.menu_open
	get_tree().call_group("monitor", "toggle_input", !menu.visible)

func _on_win():
	print("won")

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Escape by default
		menu.visible = not menu.visible
		Globals.toggle_menu(menu.visible)
		get_tree().call_group("monitor", "toggle_input", !menu.visible)

func play():
	menu.visible = false
	Globals.menu_open = false
	get_tree().call_group("monitor", "toggle_input", true)

func _on_continue_pressed():
	play()

func _on_new_game_pressed():
	play()

func _on_quit_pressed():
	get_tree().quit()
