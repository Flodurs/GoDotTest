extends Node3D

var dir: Vector3
var speed = 200
var existingTime = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform.origin+=transform.basis.z*delta*speed
	existingTime+=delta
	if existingTime >= 10:
		queue_free()
