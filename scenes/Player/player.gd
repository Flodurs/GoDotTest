extends CharacterBody3D

var speed: int = 30
var speed_cap: int = 10

func acceleration(delta, direction):
	var velocity_2d: Vector2 = Vector2(velocity.x, velocity.z)
	if velocity_2d.length() < speed_cap:
		velocity += direction * speed * delta
	else:
		velocity = velocity - velocity.normalized() * speed * delta
		

func _physics_process(delta):
	var direction: Vector3
	var camera_direction: Vector3 = $PlayerCamera.look_dir_2d
	var movement: bool = false
	
	
	
	if Input.is_action_pressed("Forward"):
		movement = true
		direction = camera_direction
		acceleration(delta, direction)
	if Input.is_action_pressed("Backward"):
		movement = true
		direction = -camera_direction
		acceleration(delta, direction)
	if Input.is_action_pressed("Right"):
		movement = true
		direction = camera_direction.rotated(Vector3(0,1,0), deg_to_rad(-90))
		acceleration(delta, direction)
	if Input.is_action_pressed("Left"):
		movement = true
		direction = camera_direction.rotated(Vector3(0,1,0), deg_to_rad(90))
		acceleration(delta, direction)
	if movement == false:
		velocity = velocity - velocity.normalized() * speed * delta
		
	
#	if not is_on_floor():
#		velocity.y -= 30 * delta
	
	move_and_slide()
