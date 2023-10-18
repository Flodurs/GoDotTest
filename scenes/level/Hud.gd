extends CanvasLayer


# Called when the node enters the scene tree for the first time.
var data = [Vector2.ZERO]
var timerA = 0
var totalTime = 0

func _ready():
	
	$Line2D.set_points(data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timerA+=delta
	totalTime+=delta
	if timerA >= 5:
		timerA=0
		data.append(Vector2(totalTime*1,get_tree().get_nodes_in_group("baumblitzer").size()))
		$Line2D.set_points(data)
	$Label.set_text(str(get_tree().get_nodes_in_group("baumblitzer").size()))
