extends Node2D

@export var tile_size: int = Globals.TILE_SIZE

@export var wall_scene: PackedScene
@export var floor_scene: PackedScene
@export var box_scene: PackedScene
@export var goal_scene: PackedScene

var spawneds:= []

func load_level(path: String, pushing: Pushing):
	
	var file = FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("Failed to open level file: " + path)
		return

	var y = 0
	while not file.eof_reached():
		var line = file.get_line()
		for x in line.length():
			var charine = line[x]
			var pos_unscaled = Vector2(x, y)
			var pos = pos_unscaled * tile_size
			
			match charine:
				"#" : # Wall
					spawn(wall_scene, pos)
					
					pushing.level_map[str(pos_unscaled)] = "#"
					
				"." : # Goal
					spawn(floor_scene, pos)
					var goal = spawn(goal_scene, pos)
					
					pushing.level_map[str(pos_unscaled)] = "."
					pushing.goals.append({"pos": pos_unscaled, "node": goal})
					
				"$" : # Box
					spawn(floor_scene, pos)
					var box = spawn(box_scene, pos)
					
					pushing.level_map[str(pos_unscaled)] = "$"
					pushing.boxes.append({"pos": pos_unscaled, "node": box})
				
				"G" : # Box Goal
					spawn(floor_scene, pos)
					var box = spawn(box_scene, pos)
					var goal = spawn(goal_scene, pos)
					
					pushing.level_map[str(pos_unscaled)] = "B"
					pushing.boxes.append({"pos": pos_unscaled, "node": box})
					pushing.goals.append({"pos": pos_unscaled, "node": goal})
					
				"@" : # Player
					spawn(floor_scene, pos)
					pushing.player.move_player(pos_unscaled)
					pushing.player_pos = pos_unscaled
					pushing.level_map[str(pos_unscaled)] = "@"
					
				" " : # Floor
					spawn(floor_scene, pos)
		y += 1

func spawn(scene: PackedScene, pos: Vector2) -> Node:
	if scene == null:
		return
	var instance = scene.instantiate()
	instance.position = pos
	spawneds.append(instance)
	add_child(instance)
	
	return instance

func despawn_all():
	for i in spawneds:
		i.queue_free()
	spawneds.clear()
