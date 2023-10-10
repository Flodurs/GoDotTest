extends CharacterBody3D

var BULLET = preload("res://scenes/projectiles/bullet.tscn")

var gravity = 3
var rotationspeed = 10
var target_y_angle = 0
var movementSpeed = 2
var targetPoint = 1

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()
	
func shoot():
	var b = BULLET.instantiate()
	b.position = position
	b.rotation = $Head.rotation
	b.rotation.y+=1.5707
	owner.add_child(b)
	
	
func _process(delta):
	processHeadRotation(delta)
	processPatrol(delta)
	
func processPatrol(delta):
	
	if targetPoint == 1:
		transform.origin.x+=movementSpeed*delta
	
	if targetPoint == 0:
		transform.origin.x-=movementSpeed*delta
		
	if transform.origin.x >= 2:
		shoot()
		targetPoint = 0
	
	if transform.origin.x <= -2:
		shoot()
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
	
	target_y_angle = dirAngle
	
	
	
	
	if abs(dirAngle-myAngle) > 0.01:
		$Head.global_rotate(Vector3(0,1,0),(dirAngle-myAngle)*-rotationspeed*delta)
		
		
	
	
	
	
	
	
	
	
	
	
