extends CharacterBody3D

var speed: int = 50
var speed_cap: int = 10
var jump_speed: int = 20
var in_air_speed: int = 10


func acceleration(delta, direction):
	var velocity_2d: Vector2 = Vector2(velocity.x, velocity.z)
	if is_on_floor():
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
	else:
		if velocity_2d.length() < speed_cap:
			velocity.x += direction.x * in_air_speed * delta
			velocity.z += direction.z * in_air_speed * delta
		else:
			velocity.x += direction.x * in_air_speed * delta
			velocity.z += direction.z * in_air_speed * delta
			velocity_2d = Vector2(velocity.x, velocity.z)
			velocity_2d = velocity_2d.normalized() * speed_cap
			velocity[0] = velocity_2d[0]
			velocity[2] = velocity_2d[1]

func _physics_process(delta):
	var direction: Vector3
	var camera_direction: Vector3 = $PlayerCamera.look_dir_2d
	var movement: bool = false
	var jumping: bool = false
	var velocity_2d: Vector2 = Vector2(velocity.x, velocity.z)
	
#	print(position)
	if not get_tree().get_nodes_in_group("console")[0].dvar_in_console:
		if Input.is_action_pressed("Forward"):
#			print("forward")
			movement = true
			direction = camera_direction
			acceleration(delta, direction)
		if Input.is_action_pressed("Backward"):
#			print("backward")
			movement = true
			direction = -camera_direction
			acceleration(delta, direction)
		if Input.is_action_pressed("Right"):
#			print("right")
			movement = true
			direction = camera_direction.rotated(Vector3(0,1,0), deg_to_rad(-90))
			acceleration(delta, direction)
		if Input.is_action_pressed("Left"):
#			print("left")
			movement = true
			direction = camera_direction.rotated(Vector3(0,1,0), deg_to_rad(90))
			acceleration(delta, direction)
		if Input.is_action_pressed("Jump") and is_on_floor():
			velocity.y = jump_speed
		
#	print(velocity.length())
	
	
	if movement == false and is_on_floor():
		
		if velocity_2d.length() > 0.05:
			velocity.x = velocity.x * 0.8
			velocity.z = velocity.z * 0.8
		else:
			velocity.x = 0
			velocity.z = 0
		
	
	if not is_on_floor():
		velocity.y -= 30 * delta
		
		
	

	move_and_slide()



