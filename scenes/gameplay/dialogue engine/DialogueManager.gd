extends Control

var Dialogue_Box_Active = false
var List_of_Character_Names = [" ", "Circe", "Chronos"]
var Log_Text = []
var dialogue_list = []

func _on_dialog_box_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			display_next_dialogue_line(dialogue_list)

func start_dialogue():
	#self.show()
	if dialogue_list.size() >= 1 and dialogue_list[0] != '':
		Dialogue_Box_Active = true
		display_dialogue_line(dialogue_list)

func display_dialogue_line(dialogue_list):
	%DialogueCharacterName.text = List_of_Character_Names[int(dialogue_list[0][0])]
	Log_Text.push_back(dialogue_list[0])
	var current_line = dialogue_list[0].substr(1)
	%DialogueText.text = current_line
	self.show()
	%Hotbar.hide()

func display_next_dialogue_line(dialogue_list):
	dialogue_list.pop_front()
	if dialogue_list.size() == 0:
		dialogue_list = []
		Dialogue_Box_Active = false
		self.hide()
		%Hotbar.show()
	else:
		display_dialogue_line(dialogue_list)

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
