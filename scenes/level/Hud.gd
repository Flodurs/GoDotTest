extends CanvasLayer


# Called when the node enters the scene tree for the first time.
var dataBli = [Vector2.ZERO]
var dataBau = [Vector2.ZERO]

var timerA = 0
var totalTime = 0

var plotSpeed = 2

func _ready():
	pass
#	$baumblitzerGraph/Line2D.set_points(dataBli)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#Blitzer:
	$baumblitzerGraph.visible = get_tree().get_nodes_in_group("console")[0].cvar_show_eco_graph
	timerA+=delta
	totalTime+=delta
	if timerA >= 3:
		
		dataBli.append(Vector2(totalTime*plotSpeed,-get_tree().get_nodes_in_group("baumblitzer").size()))
		$baumblitzerGraph/Line2D.position.x-=timerA*plotSpeed
		$baumblitzerGraph/Line2D.set_points(dataBli)
		
		
		var totalTreeSize = 0
		for baum in get_tree().get_nodes_in_group("alleBaeume"):
			totalTreeSize += baum.scale.y
		dataBau.append(Vector2(totalTime*plotSpeed,-totalTreeSize*0.5))
		$baumblitzerGraph/BaumGraph.position.x-=timerA*plotSpeed
		$baumblitzerGraph/BaumGraph.set_points(dataBau)
		
		timerA=0
		
	$Label.set_text(str(get_tree().get_nodes_in_group("baumblitzer").size()))
	
	
		
	


