extends CharacterBody3D

var speed: int = 30
var speed_cap: int = 10
var jump_speed: int = 20


func acceleration(delta, direction):
	var velocity_2d: Vector2 = Vector2(velocity.x, velocity.z)
	if velocity_2d.length() < speed_cap:
		velocity.x += direction.x * speed * delta
		velocity.z += direction.z * speed * delta
	else:
		velocity.x += direction.x * speed * delta
		velocity.z += direction.z * speed * delta
		velocity_2d = Vector2(velocity.x, velocity.z)
		velocity_2d = velocity_2d.normalized() * speed_cap
		velocity[0] = velocity_2d[0]
		velocity[2] = velocity_2d[1]

func _physics_process(delta):
	var direction: Vector3
	var camera_direction: Vector3 = $PlayerCamera.look_dir_2d
	var movement: bool = false
	
	
#	print(position)
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
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = jump_speed
#	print(velocity.length())
	

	if movement == false and is_on_floor():
		velocity = velocity - velocity.normalized() * speed * delta
		if velocity.length() < 0.01:
			velocity = Vector3.ZERO
		
	
	if not is_on_floor():
		velocity.y -= 30 * delta
		
	

	move_and_slide()



