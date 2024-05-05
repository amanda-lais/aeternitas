extends Sprite2D

signal strategy_click
#signal strategy_info (strategy_name, strategy_is_active)

var strategy_name
var strategy_info

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hover.hide()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#%DialogueManager.dialogue_list = %EnvironmentItems.all_dialogues_at_location[get_name()]
			#%DialogueManager.start_dialogue()
			#clicked_item_name = get_name()
			strategy_click.emit()

func _on_area_2d_mouse_entered():
	$Hover.show()

func _on_area_2d_mouse_exited():
	$Hover.hide()
