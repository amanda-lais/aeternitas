extends Node2D

var Dialogue_Box_Active = false
var List_of_Character_Names = [" ", "Circe", "Chronos"]
var Dialogue_Text_List = []
var Log_Text = []

func display_name(current_dialogue):
	%Character_Name.text = List_of_Character_Names[int(current_dialogue[0])]

func display_dialogue(dialogue_list):
	print(dialogue_list[0].substr(1))
	%Dialogue_Text.text = dialogue_list[0].substr(1)

# Called when the node enters the scene tree for the first time.
func _ready():
	display_name("1testing...")
	display_dialogue(["1testing..."])
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



