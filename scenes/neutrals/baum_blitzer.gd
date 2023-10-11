extends Node3D

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
var timeSinceLastBlitz =  rng.randf_range(0,1.5)

var targetBaumIndex = 0
var time = 0

var speed = 0.5


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeSinceLastBlitz+=delta
	time+=delta
	var dir = (get_tree().get_nodes_in_group("alleBaeume")[targetBaumIndex].position - position)
	
	dir.y += 2*get_tree().get_nodes_in_group("alleBaeume")[targetBaumIndex].scale.y
	
	var dist = dir.length()
	dir = dir.normalized()
	position+=dir*delta*speed*dist
	rotate(dir,0.02*cos(3.1415*time))
	
	
	if dist < 0.1:
		speed = get_tree().get_nodes_in_group("alleBaeume")[targetBaumIndex].scale.y*0.3
		get_tree().get_nodes_in_group("alleBaeume")[targetBaumIndex].shrink()
		
		targetBaumIndex=rng.randi() % get_tree().get_nodes_in_group("alleBaeume").size()
		rotation = Vector3(0,0,0)
		time = 0
	
