extends Node3D

var Baum = preload("res://scenes/Objects/baum.tscn")
var count = 0
var baumNum = 100

var rng = RandomNumberGenerator.new()

var size = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func placeTree(pos):
	
	var b = Baum.instantiate()
	b.position = pos
	
	
	
	add_child(b)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	count+=1
	if count <= baumNum:
		placeTree(Vector3(rng.randf_range(-size, size),0,rng.randf_range(-size, size)))
	
