extends CharacterBody2D

var grid_size: int = Globals.TILE_SIZE
var player_pos := Vector2.ZERO

func move_player(new_pos: Vector2):
	player_pos = new_pos
	position = player_pos * grid_size

func set_anim(direction: String):
	match direction:
		"up", "down", "right", "left":
			$AnimatedSprite2D.animation = direction
		var _a:
			print("no dir named ", direction)
