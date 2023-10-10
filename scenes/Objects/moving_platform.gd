extends AnimatableBody3D

var speed: int = 2
var units_moved: float = 0
var max_distance: int = 10
var min_distance: int = 0
var change_direction: bool = false
var body_entered: bool = false

func _physics_process(delta):
	if units_moved >= max_distance:
		change_direction = true
	if units_moved <= min_distance:
		change_direction = false
	
	if not change_direction:
		transform.origin.x += speed * delta
		units_moved += speed * delta

	if change_direction:
		transform.origin.x -= speed * delta
		units_moved -= speed * delta
	


