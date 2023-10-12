extends Node3D
var rng = RandomNumberGenerator.new()
var timeSinceLastGrow = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("alleBaeume")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeSinceLastGrow+=delta
	if timeSinceLastGrow > 2:
		timeSinceLastGrow=0
		if (rng.randi() % 2) == 0:
			grow()
	
	
func grow():
	scale.y += 0.1
	
func shrink():
	scale.y -= 1
	
