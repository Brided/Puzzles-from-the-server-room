extends SokobanTileMove

class_name SokobanPlayer

func _init():
	tile_data.change_type("Player")

func move_dir(direction: Vector2i):
	move_to(tile_data.grid_pos.add(direction))
	set_anim(direction)

func set_anim(direction: Vector2i):
	match direction:
		Vector2i.UP:
			$AnimatedSprite2D.animation = "up"
		Vector2i.DOWN:
			$AnimatedSprite2D.animation = "down"
		Vector2i.LEFT:
			$AnimatedSprite2D.animation = "left"
		Vector2i.RIGHT:
			$AnimatedSprite2D.animation = "right"
		var _a:
			print("no dir named ", direction)
