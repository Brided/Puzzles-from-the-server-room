extends Node3D

@export var max_tilt: float = 32.0 # degrees
@export var tilt_speed: float = 7.0
@export var zoom_speed: float = 7.0

const zoomed_in:= 30.0
const zoomed_out:= 80.0

var tilt_target:= Vector2.ZERO
var zoom_target:= zoomed_in
var rot_target:= Vector2.ZERO

var looking_mouse:= false
var looking_stick:= false

var mouse_trapped:= false

# ACTIVE

var is_active:= true

func set_active(state: bool):
	is_active = state

func _ready():
	$Camera3D.fov = zoom_target

func _on_monitor_toggle_input_signal(state):
	set_active(state)

func _input(event):
	if !is_active:
		return
	
	if event.is_action_pressed("cam_looking"):
		looking_mouse = !looking_mouse
		mouse_trapped = looking_mouse

func _process(delta):
	if !is_active:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
		toggle_blur(true)
		set_blurred()
		
		zoom_target = zoomed_out
		rot_target = Vector2.ZERO
		lerp_all(delta, true)
	else:
		set_zoomed()
		process_camera(delta)
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED if mouse_trapped else Input.MOUSE_MODE_VISIBLE

func process_camera(delta):
		# Mouse offset from center
		var mouse_offset = (get_viewport().get_mouse_position() - get_viewport().size * 0.5) / (get_viewport().size * 0.5)

		# Controller right stick (assuming actions defined in InputMap)
		var stick = Vector2(
				Input.get_action_strength("cam_look_right") - Input.get_action_strength("cam_look_left"),
				Input.get_action_strength("cam_look_down") - Input.get_action_strength("cam_look_up"),
		)
		
		if looking_mouse:
			tilt_target = mouse_offset
			zoom_target = zoomed_out
		else:
			tilt_target = Vector2.ZERO
			zoom_target = zoomed_in
		
		looking_stick = stick.length() > 0.01
		if looking_stick:
			tilt_target = stick
			zoom_target = zoomed_out
			
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			looking_mouse = false

		rot_target = Vector2(
			deg_to_rad(-tilt_target.y * max_tilt),
			deg_to_rad(-tilt_target.x * max_tilt)
		)
		
		lerp_all(delta, !(looking_stick || looking_mouse))

func lerp_all(delta, blurred: bool):
		rotation.x = lerp_angle(rotation.x, rot_target.x, delta * tilt_speed)
		rotation.y = lerp_angle(rotation.y, rot_target.y, delta * tilt_speed)
		
		$Camera3D.fov = lerp($Camera3D.fov, zoom_target, delta * zoom_speed)
		
		toggle_blur(blurred)

func toggle_blur(state: bool):
	$Camera3D.attributes.dof_blur_far_enabled = state

func set_far_blur(dist: float, transit: float):
	$Camera3D.attributes.dof_blur_far_distance = dist
	$Camera3D.attributes.dof_blur_far_transition = transit

func set_blurred():
	set_far_blur(0.01, -1.0)

func set_zoomed():
	set_far_blur(1.5, 1.0)
