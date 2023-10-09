extends Camera3D

func _process(delta):
	if Input.is_action_pressed("CamUp"):
		rotate(Vector3(1,0,0), deg_to_rad(1))
