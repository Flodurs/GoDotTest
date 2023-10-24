extends Node3D
var energy=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if energy >=0.05*get_tree().get_nodes_in_group("blitzer").size():
		energy-=0.05*get_tree().get_nodes_in_group("blitzer").size()
		get_tree().get_nodes_in_group("mobmanager")[0].createBlitzer(Vector3(0,200,0))
	

