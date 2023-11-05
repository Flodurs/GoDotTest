extends CharacterBody3D

var mouse_sensitivity: float = 0.01
var twist_input: float = 0
var pitch_input: float = 0
var cam_pitch_max: int = 60
var max_speed: float = 30
var last_direction: Vector3
var acceleration: float = 100
var deceleration: float = -70
var forward_velocity: float

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	
	var input: Vector3 = Vector3.ZERO
	var direction: Vector3
	var relative_velocity: Vector3
	
	#check wether mouse escaped
	if Input.is_action_just_pressed("Esc"):
		if Input.mouse_mode == 2:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
	#update camera rotation
	$TwistInput.rotate_y(twist_input)
	$TwistInput/PitchInput.rotate_z(pitch_input)
	$TwistInput/PitchInput.rotation.z = clamp($TwistInput/PitchInput.rotation.z, deg_to_rad(-cam_pitch_max), deg_to_rad(cam_pitch_max))
	
	twist_input = 0
	pitch_input = 0

	
	
	#get keyboard input
	input.x = Input.get_axis("Backward", "Forward")
	input.z = Input.get_axis("Left", "Right")
	
	
	
	direction = ($TwistInput.basis * input).normalized()
	relative_velocity = velocity * $TwistInput.basis
	
	
	
	if direction != Vector3.ZERO:
		last_direction = direction
		forward_velocity += acceleration * delta
	
	
	forward_velocity += deceleration * delta
	forward_velocity = clamp(forward_velocity, 0, max_speed)
	
	velocity.x = last_direction.x * forward_velocity
	velocity.z = last_direction.z * forward_velocity
	
	
	
	if not is_on_floor():
		velocity.y -= 1
	print(velocity.y)
	move_and_slide()
	

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
