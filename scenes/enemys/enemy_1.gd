extends CharacterBody3D

var BULLET = preload("res://scenes/projectiles/bullet.tscn")

var gravity = 3
var rotationspeed = 10
var target_y_angle = 0
var movementSpeed = 200
var targetPoint = 1
var enableShooting = 0

var shotfreq = 1
var timeSinceLastShot = 0

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()
	
func shoot(delta):
	timeSinceLastShot+=delta
	if timeSinceLastShot >= shotfreq:
		timeSinceLastShot = 0
		var b = BULLET.instantiate()
		b.position = $Head/BulletSpawn.global_position
		print(global_position,position)
		
		b.rotation = $Head.rotation
		b.rotation.y+=1.5707
		owner.add_child(b)
	
	
func _process(delta):
	velocity.x = 0
	velocity.z = 0
	processHeadRotation(delta)
	processPatrol(delta)
	
func processPatrol(delta):
	var player = get_tree().get_nodes_in_group("Player")[0]
	if abs((player.position - position).length()) <= 10:
		shoot(delta)
		velocity+=$Head.global_transform.basis.z.normalized()*delta*movementSpeed
	else:
		velocity+=$Head.global_transform.basis.x.normalized()*delta*movementSpeed
		
	
	
	
	

	
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
		
		
	
	
	
	
	
	
	
	
	
	
