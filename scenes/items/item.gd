extends Sprite2D

var item_name
var item_info = {}
var has_alarm_active

signal item_click

var workbench_d = {
	"prompt": "0Deseja consertar o cetro?",
	"success": "0Circe consertou o cetro com sucesso!",
	"fail": "0Circe se distraiu...",
	"no": "0Talvez depois.",
	"lacking": "0Circe não tem material o suficiente...",
	"already": "1...? Eu já consertei o cetro."
	}

var cauldron_d = {
	"prompt": "0Deseja preparar poções?",
	"success": "0Circe fez as poções com sucesso!",
	"fail": "0A poção queimou e deu errado...",
	"no": "0Talvez depois.",
	"lacking": "0Circe não tem vegetais mágicos o suficiente..."
	}

func audio_collect():
	$"../../../Inventory/Fruit collect 1_wav".play()

func audio_cant_do():
	$"../../DialogueOptions/Fantasy_UI cant do".play()

func audio_mine():
	$"../../../Inventory/Rock Wall 2".play()

func audio_repair():
	$"../../../Inventory/Sword Parry".play()

func workbench_lacking():
	audio_cant_do()
	%DialogueManager.run_dialogue(workbench_d["lacking"])

func workbench_already():
	audio_cant_do()
	%DialogueManager.run_dialogue(workbench_d["already"])

func cauldron_lacking():
	audio_cant_do()
	%DialogueManager.run_dialogue(cauldron_d["lacking"])

func mine_stone():
	audio_mine()
	var amount
	if %ToDoList.is_active == true:
		amount = 2
	else:
		amount = randi_range(1, 2)
		audio_collect()
		await %DialogueManager.run_dialogue("0" + str(int(amount)) + " pedra(s) adicionada(s) ao inventário!")
	%Inventory.add_to_inventory("stone", amount)
	await %EnvironmentStrategies.choose_strategy_3(
		false, true, false)

func repair():
	%Inventory.add_to_inventory("stone", -2)
	%Inventory.add_to_inventory("staff", 1)
	await %EnvironmentStrategies.choose_strategy_3(
		false, true, false)

func _ready():
	$Hover.hide()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			item_click.emit()

func _on_area_2d_mouse_entered():
	$Hover.show()

func _on_area_2d_mouse_exited():
	$Hover.hide()
