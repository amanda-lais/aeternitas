extends Sprite2D

#signal clicked_item
#var clicked_item_name
signal item_click

var item_name
var item_info = {}
var used_up

#var location_items = {
	#item_name: {used_up,
	#item_name
	#}
#}

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hover.hide()
	item_name = get_name()
	item_info = {"item_name": item_name, "used_up": 0}
	#item_name = get_name()
	%EnvironmentItems.location_items[item_name] = item_info

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#print("spiderwebbbb")
			print(item_name)
			print(item_info)
			#%DialogueManager.dialogue_list = %EnvironmentItems.all_dialogues_at_location[get_name()]
			#%DialogueManager.start_dialogue()
			#clicked_item_name = get_name()
			item_click.emit()

func _on_area_2d_mouse_entered():
	$Hover.show()

func _on_area_2d_mouse_exited():
	$Hover.hide()
