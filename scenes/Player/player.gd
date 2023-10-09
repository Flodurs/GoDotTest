extends CharacterBody3D

var speed: int = 10
var direction: Vector3

func _process(delta):
	direction = Vector3.ZERO
	if Input.is_action_pressed("Forward"):
		direction = $PlayerCamera.look_dir_2d
	if Input.is_action_pressed("Backward"):
		direction = -$PlayerCamera.look_dir_2d
	
	velocity = direction * speed
	move_and_slide()
