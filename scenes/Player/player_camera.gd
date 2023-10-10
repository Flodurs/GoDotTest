extends Camera3D

var rot_cap: int = 70
var rotation_speed: = 100
var camera_direction_3d: Vector3
var look_dir_2d: Vector3

func _process(delta):

	if Input.is_action_pressed("CamUp") and rotation.x < deg_to_rad(rot_cap):
		rotation.x += deg_to_rad(rotation_speed) * delta
	if Input.is_action_pressed("CamDown") and rotation.x > deg_to_rad(-rot_cap):
		rotation.x -= deg_to_rad(rotation_speed) * delta
	if Input.is_action_pressed("CamRight"):
		rotation.y -= deg_to_rad(rotation_speed) * delta
	if Input.is_action_pressed("CamLeft"):
		rotation.y += deg_to_rad(rotation_speed) * delta

func _physics_process(delta):
	camera_direction_3d = ($Marker3D.global_position - global_position).normalized()
	look_dir_2d[0] = camera_direction_3d[0]
	look_dir_2d[1] = 0
	look_dir_2d[2] = camera_direction_3d[2]
	look_dir_2d = look_dir_2d.normalized()
