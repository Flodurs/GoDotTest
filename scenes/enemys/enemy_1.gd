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
	var map_xz: Vector2 
	map_xz.x=dir.x
	map_xz.y=dir.z
	

	
	
	var aMap_xz: Vector2
	aMap_xz.x = transform.basis.x.x
	aMap_xz.y = transform.basis.x.z
	
	var dirAngle = map_xz.angle()
	var myAngle = aMap_xz.angle()
	
	print(dirAngle-myAngle)
	
	
	if abs(dirAngle-myAngle) > 0.01:
		rotate_y((dirAngle-myAngle)*-0.03)
	
	
	
	
	
	
	
	
	
