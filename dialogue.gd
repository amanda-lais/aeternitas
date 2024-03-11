extends Node2D

var List_of_Character_Names = ["", "Circe", "Chronos"]
var Dialogue = []

func display_name(current_dialogue):
	%Character_Name.text = List_of_Character_Names[int(current_dialogue[0])]

func display_dialogue(dialogue_list):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	display_name("0testing...")
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
