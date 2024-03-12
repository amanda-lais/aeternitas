extends Node2D

var Dialogue_Box_Active = false
var List_of_Character_Names = [" ", "Circe", "Chronos"]
var Log_Text = []
var dialogue_list = ["1testing...", "2cuuuuuu", "1buuuuuu", "2ceeeeeee", "0taaaaaaa"]

func display_dialogue_line(dialogue_list):
	%Character_Name.text = List_of_Character_Names[int(dialogue_list[0][0])]
	Log_Text.push_back(dialogue_list[0])
	var current_line = dialogue_list[0].substr(1)
	%Dialogue_Text.text = current_line

func display_next_dialogue_line(dialogue_list):
	dialogue_list.pop_front()
	if dialogue_list.size() == 0:
		Dialogue_Box_Active = false
		print(Log_Text)
		hide()
	else:
		display_dialogue_line(dialogue_list)

# Called when the node enters the scene tree for the first time.
func _ready():
	display_dialogue_line(dialogue_list)
	Dialogue_Box_Active = true
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_dialogue_box_collision_2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and Dialogue_Box_Active:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			display_next_dialogue_line(dialogue_list)
