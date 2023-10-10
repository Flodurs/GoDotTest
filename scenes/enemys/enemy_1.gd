extends CharacterBody3D


var gravity = 3
var rotationspeed = 1
var target_y_angle = 0

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()
	
	
func _process(delta):
	var player = get_tree().get_nodes_in_group("Player")[0]
	var dir = player.transform.origin - transform.origin
	if dir.dot(transform.basis.z) > 0:
	
	
	
	
	
	
	
	
	
