extends CharacterBody3D


var gravity = 3
var rotationspeed = 2
var target_y_angle = 0
var movementSpeed = 2
var targetPoint = 1

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()
	
	
func _process(delta):
	processHeadRotation(delta)
	processPatrol(delta)
	
func processPatrol(delta):
	
	if targetPoint == 1:
		transform.origin.x+=movementSpeed*delta
	
	if targetPoint == 0:
		transform.origin.x-=movementSpeed*delta
		
	if transform.origin.x >= 10:
		targetPoint = 0
	
	if transform.origin.x <= -10:
		targetPoint = 1
		
	
	
	
	

	
func processHeadRotation(delta):
	var player = get_tree().get_nodes_in_group("Player")[0]
	
	var dir = player.global_transform.origin - $Head.global_transform.origin
	var map_xz: Vector2 
	map_xz.x=dir.x
	map_xz.y=dir.z
	

	
	
	var aMap_xz: Vector2
	aMap_xz.x = $Head.global_transform.basis.x.x
	aMap_xz.y = $Head.global_transform.basis.x.z
	
	var dirAngle = map_xz.angle()
	var myAngle = aMap_xz.angle()
	
	
	
	
	if abs(dirAngle-myAngle) > 0.01:
		$Head.global_rotate(Vector3(0,1,0),(dirAngle-myAngle)*-rotationspeed*delta)
		
		
	
	
	
	
	
	
	
	
	
	
