extends CharacterBody3D



var timeSinceLastJump = 0
var gravity = 10

var powerxz= 12
var powery = 12

var rng = RandomNumberGenerator.new()




func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.z=0
		velocity.x=0
	
	
	timeSinceLastJump+=delta
	if timeSinceLastJump > 5:
		timeSinceLastJump=0
		velocity.y = rng.randf_range(0, powery)
		velocity.z=rng.randf_range(-powerxz, powerxz)
		velocity.x=rng.randf_range(-powerxz, powerxz)
		
	
	

	move_and_slide()
