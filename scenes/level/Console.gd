extends Node2D

var lastCom = ""

var cvar_show_eco_graph = false
var dvar_in_console = false


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pr = Input.is_action_just_pressed("Enter")
	if pr and visible == false:
		visible=true
		dvar_in_console = true
		pr=false
	
	if pr and visible == true:
		visible=false
		dvar_in_console = false
		if $InputLabel.text.length() > 0:
			processCommand($InputLabel.text)
		$InputLabel.text = ""
	
	if visible == true:
		if Input.is_action_just_pressed("Backspace"):
			
			$InputLabel.text=$InputLabel.text.left($InputLabel.text.length() - 1)
			
	if Input.is_action_just_pressed("CamUp"):
		$InputLabel.text=lastCom
		
		
func _input(event):
	if event is InputEventKey and event.is_pressed() and visible == true:
		var key_text = event.unicode
		if key_text == 0 :
			return 0
		
		$InputLabel.text += char(key_text)
		
func processCommand(command):
	if command[0] != "/":
		return 0
	lastCom = command
	command = command.erase(0,1)
	
	var spl = command.split(" ")
	
	if spl[0] == "test":
		print("lol")
	
	if spl[0] == "show_eco_graph":
		if spl[1] == "true":
			cvar_show_eco_graph = true
		else:
			cvar_show_eco_graph = false
	

		
		
