extends Node3D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
var intermezzoTimer = 0


var nestTarget = false

var time = 0
var splitCount = 0
var splitBool = 0
var speed = 30
var timeoflife=0

var energy = 0

var targetPos: Vector3 
var state = 0
var Path = [Vector3.ZERO]
var currentTargetPointIndex = 0
var pathLen = 10
var randomOffset=10


var iFlag = true

#state0
var targetBaumIndex = 0


#state1
var interruptedState = 0
var timerA = 0
var intTime = 0


#state2
var intTargetPos : Vector3


func _ready():
	add_to_group("baumblitzer")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	followPath(delta)
	processMovement(delta)
	
#0=Consuming Tree, 1=Returning to Nest, 2=random intermezzo

	if(state == 0):
		processState_0()
	
	if(state == 1):
		processState_1()
		
	if(state == 2):
		processState_2(delta)
		
		
		
		

			
	
	
	
	if timeoflife >= 40:
		
		queue_free()
		
	timeoflife+=delta
	
		

	
func split():
	get_tree().get_nodes_in_group("mobmanager")[0].createBlitzer(position)
	
func processMovement(delta):
	time+=delta
	var dir = targetPos-position
	var dist = dir.length()
	dir = dir.normalized()
	position+=dir*delta*speed
	rotate(dir,0.02*cos(3.1415*time))
	
	
func processState_0():
	var tPos
	if iFlag == true:
		iFlag = false
		targetBaumIndex = rng.randi() % get_tree().get_nodes_in_group("alleBaeume").size()
		tPos=get_tree().get_nodes_in_group("alleBaeume")[targetBaumIndex].position
		tPos.y+=2*get_tree().get_nodes_in_group("alleBaeume")[targetBaumIndex].scale.y	
		createPath(tPos)
	
	
	if currentTargetPointIndex==9999:
		
		state = 1
		iFlag = true
		if get_tree().get_nodes_in_group("alleBaeume")[targetBaumIndex].scale.y >= 1:
			energy+=1
			get_tree().get_nodes_in_group("alleBaeume")[targetBaumIndex].shrink()

func processState_1():
	if iFlag == true:
		iFlag = false
		createPath(Vector3(0,200,0))
	
	
	if currentTargetPointIndex==9999:
		state = 0
		iFlag = true
		get_tree().get_nodes_in_group("Ygg")[0].energy+=energy
		energy = 0
		
		
func processState_2(delta):
	if iFlag == true:
		iFlag = false
		
		intTargetPos = targetPos
		targetPos.x+=rng.randf_range(-10,10)
		targetPos.y+=rng.randf_range(-10,10)
		targetPos.z+=rng.randf_range(-10,10)
		intTime = rng.randf_range(0,1)
	timerA+=delta
	if timerA >= intTime:
		state = interruptedState
		timerA=0
		
func createPath(endPos):
	var distance = (endPos - position).length()
	var direction = (endPos - position).normalized()
	currentTargetPointIndex=0
	Path = []
	for i in range(1,pathLen+1):
		Path.append(position+i*direction*distance/pathLen)
	for i in range(0,pathLen-1):
		Path[i]+=Vector3(rng.randf_range(-randomOffset,randomOffset),rng.randf_range(-randomOffset,randomOffset),rng.randf_range(-randomOffset,randomOffset))

	
		
		
func followPath(delta):
	
	if currentTargetPointIndex < Path.size():
		if currentTargetPointIndex == 0:
			targetPos=Path[0]
		if (Path[currentTargetPointIndex]-position).length() <= 0.5:
			currentTargetPointIndex+=1
			if currentTargetPointIndex >= Path.size():
				rotation=Vector3(0,0,0)
				currentTargetPointIndex=9999
			else:
				targetPos=Path[currentTargetPointIndex]
				
		
		
	
	

	


		
		
	


	
		
