extends Node3D

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
var timeSinceLastBlitz =  rng.randf_range(0,1.5)

var targetBaumIndex = 0


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeSinceLastBlitz+=delta
	var dir = (get_tree().get_nodes_in_group("alleBaeume")[targetBaumIndex].position - position)
	
	dir.y += 2*get_tree().get_nodes_in_group("alleBaeume")[targetBaumIndex].scale.y
	
	var dist = dir.length()
	dir = dir.normalized()
	position+=dir*delta*1*dist
	if dist < 0.1:
		get_tree().get_nodes_in_group("alleBaeume")[targetBaumIndex].shrink()
		targetBaumIndex=rng.randi() % get_tree().get_nodes_in_group("alleBaeume").size()
	
