extends CharacterBody3D

var mouse_sensitivity: float = 0.01
var twist_input: float = 0
var pitch_input: float = 0
var cam_pitch_max: int = 60
var brake_speed: int = 2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	var acceleration: float = 5
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
	
	
	velocity *= 0.8
	
	
	
	
	#set acceleration
	velocity += direction * acceleration
	
	if not is_on_floor():
		velocity.y -= 1
	print(velocity.y)
	move_and_slide()
	

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
