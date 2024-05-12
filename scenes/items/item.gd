extends Sprite2D

var item_name
var item_info = {}
var has_alarm_active
var is_unlocked = false

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
	$"../../../Gameplay/Inventory/Fruit collect 1_wav".play()

func audio_cant_do():
	$"../../../Gameplay/DialogueOptions/Fantasy_UI cant do".play()

func audio_mine():
	$"../../../Gameplay/Inventory/Rock Wall 2".play()

func audio_repair():
	$"../../../Gameplay/Inventory/Sword Parry".play()

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

func brew_success():
	%Inventory.add_to_inventory("vegetable", -2)
	%Overlay.show()
	$"../Cauldron/Preparation/Cooking".show()
	await %DialogueManager.run_dialogue("0...")
	await %DialogueManager.run_dialogue("0[wave]....[/wave]")
	await %DialogueManager.run_dialogue("0[wave].....[/wave]")
	await %DialogueManager.run_dialogue("0[wave].......[/wave]")
	%Alarm.crow_audio()
	await %DialogueManager.run_dialogue("1[shake]!![/shake]")
	$"../Cauldron/Preparation/Cooking".hide()
	$"../Cauldron/Preparation/Done".show()
	await %DialogueManager.run_dialogue("1Okay, a poção está pronta!")
	$"../Cauldron/Preparation/Done".hide()
	await %EnvironmentStrategies.choose_strategy_3(
		false, true, false)

func brew_fail():
	%Inventory.add_to_inventory("vegetable", -2)
	%Overlay.show()
	$"../Cauldron/Preparation/Cooking".show()
	await %DialogueManager.run_dialogue("0...")
	await %DialogueManager.run_dialogue("0[wave]....[/wave]")
	await %DialogueManager.run_dialogue("0[wave].....[/wave]")
	await %DialogueManager.run_dialogue("0[wave].......[/wave]")
	await %DialogueManager.run_dialogue("1[shake]!![/shake]")
	$"../Cauldron/Preparation/Cooking".hide()
	$"../Cauldron/Preparation/Wrong".show()
	await %DialogueManager.run_dialogue("1Oops...")
	await %DialogueManager.run_dialogue("0A poção queimou e deu errado...")
	$"../Cauldron/Preparation/Wrong".hide()

func repair():
	%Inventory.add_to_inventory("stone", -2)
	%Inventory.add_to_inventory("staff", 1)
	await %EnvironmentStrategies.choose_strategy_3(
		false, true, false)

func _ready():
	$Hover.hide()
	$"../FruitTree/Hover2".hide()
	$"../Stone/Hover2".hide()
	

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			item_click.emit()

var prompt

func click_dialogue(prompt):
	await %DialogueManager.run_dialogue(prompt)
	%DialogueOptions.default_option_box()
	%DialogueOptions.show_options(2)
	var choice = await %DialogueOptions.option_chosen
	if choice == 1:
		return true
	elif choice == 2:
		%DialogueOptions.cancel_audio()
		return false
	#if choice == 1:
		#daymanager+1
		#pass
#		outcome = %Execution.action()
#		if outcome == true:
#			await run_dialogue(dialogue_success)
#		else:
#			await run_dialogue(dialogue_fail)
#		return outcome
#	elif option_number == 2:
#		%DialogueOptions.cancel_audio()
#		await run_dialogue(dialogue_no)

func _on_area_2d_mouse_entered():
	$Hover.show()
	if get_name() == "FruitTree":
		$Hover2.show()
		$Hover.play()
		$"../FruitTree/Tree".hide()
	elif get_name() == "Stone":
		$"../Stone/Hover2".show()
	elif get_name() == "Crops":
		if %Crops.crop_current_status == "can plant":
			$"../Crops/Hover".show()
		elif %Crops.crop_current_status == "planted":
			$"../Crops/Hover2".show()
		elif %Crops.crop_current_status == "watered":
			$"../Crops/Hover2".show()
			$"../Crops/Hover3".show()
	elif get_name() == "Workbench":
		$"../Workbench/Hover2".show()
	elif get_name() == "Cauldron":
		$"../Cauldron/Hover2".show()
	#elif get_name() == "Tower":
		#$Hover.show()

func _on_area_2d_mouse_exited():
	$Hover.hide()
	if get_name() == "FruitTree":
		$Hover2.hide()
		$"../FruitTree/Tree".show()
		$"../FruitTree/Tree".play()
	elif get_name() == "Stone":
		$"../Stone/Hover2".hide()
	elif get_name() == "Crops":
		if %Crops.crop_current_status == "can plant":
			$"../Crops/Hover".hide()
		elif %Crops.crop_current_status == "planted":
			$"../Crops/Hover2".hide()
		elif %Crops.crop_current_status == "watered":
			$"../Crops/Hover2".hide()
			$"../Crops/Hover3".hide()
	elif get_name() == "Workbench":
		$"../Workbench/Hover2".hide()
	elif get_name() == "Cauldron":
		$"../Cauldron/Hover2".hide()
	#elif get_name() == "Tower":
		#$Tower/Hover.hide()
