extends Sprite2D

signal item_click

var item_name
var item_info = {}
var used_up

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hover.hide()
	item_name = get_name()
	item_info = {"item_name": item_name, "used_up": 0}
	%EnvironmentItems.location_items[item_name] = item_info

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#print("spiderwebbbb")
			#%DialogueManager.dialogue_list = %EnvironmentItems.all_dialogues_at_location[get_name()]
			#%DialogueManager.start_dialogue()
			#clicked_item_name = get_name()
			item_click.emit()

func _on_area_2d_mouse_entered():
	$Hover.show()

func _on_area_2d_mouse_exited():
	$Hover.hide()
