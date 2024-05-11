extends Sprite2D

signal item_click

var workbench_d = {
	"prompt": "0Deseja consertar o cetro?",
	"success": "0Circe consertou o cetro com sucesso!",
	"fail": "0Circe se distraiu...",
	"no": "0Talvez depois.",
	"lacking": "0Circe não tem material o suficiente..."
	}

func audio_cant_do():
	$"../../DialogueOptions/Fantasy_UI cant do".play()

func workbench_lacking():
	audio_cant_do()
	%DialogueManager.run_dialogue(workbench_d["lacking"])

var item_name
var item_info = {}
var has_alarm_active

# Called when the node enters the scene tree for the first time.
#func _ready():
#	$Hover.hide()
#	item_name = get_name()
#	item_info = {"item_name": item_name, "used_up": 0}
#	%EnvironmentItems.location_items[item_name] = item_info

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			item_click.emit()

func _on_area_2d_mouse_entered():
	$Hover.show()

func _on_area_2d_mouse_exited():
	$Hover.hide()
