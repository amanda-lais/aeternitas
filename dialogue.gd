extends Node2D

var Dialogue_Box_Active = false
var List_of_Character_Names = [" ", "Circe", "Chronos"]
var Log_Text = []
var dialogue_list = []

func start_dialogue(dialogue_list):
	print(dialogue_list)
	display_dialogue_line(dialogue_list)
	Dialogue_Box_Active = true
	show()

func display_dialogue_line(dialogue_list):
	%Character_Name.text = List_of_Character_Names[int(dialogue_list[0][0])]
	Log_Text.push_back(dialogue_list[0])
	var current_line = dialogue_list[0].substr(1)
	%Dialogue_Text.text = current_line
	print(current_line)

func display_next_dialogue_line(dialogue_list):
	dialogue_list.pop_front()
	if dialogue_list.size() == 0:
		Dialogue_Box_Active = false
		#hide()
		#print(Log_Text)
	else:
		display_dialogue_line(dialogue_list)

func _on_dialogue_box_collision_2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			display_next_dialogue_line(dialogue_list)
			print("Left button was clicked at ", event.position)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
