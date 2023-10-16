extends Node3D

var rng = RandomNumberGenerator.new()

var ch = preload("res://scenes/neutrals/baum_blitzer.tscn")
# Called when the node enters the scene tree for the first time.
var firstSpawnFlag = 0


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if firstSpawnFlag == 0:
		firstSpawnFlag=1
		createBlitzer(Vector3(0,5,0))
	
func createBlitzer(pos):
	var c = ch.instantiate()
	c.position = pos
	
	c.add_to_group("blitzer")
	c.targetBaumIndex=rng.randi() % get_tree().get_nodes_in_group("alleBaeume").size()
	owner.add_child(c)
	

	
