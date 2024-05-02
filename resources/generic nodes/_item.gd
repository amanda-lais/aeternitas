extends Sprite2D

#var dialogue_list = []

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			%DialogueManager.dialogue_list = %Items.all_dialogues_at_location[get_name()]
			%DialogueManager.start_dialogue()

func _on_area_2d_mouse_entered():
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	pass # Replace with function body.
