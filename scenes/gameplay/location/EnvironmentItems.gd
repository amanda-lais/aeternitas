extends CanvasGroup

var location_items = {}
var outcome

signal show_todolist
signal task_finished(task_id)

func _on_fruit_tree_item_click():
	%FruitTree.tree_sound()
	%DialogueOptions.default_option_box()
	if %FruitTree.can_forage == 0:
		if await %FruitTree.click_dialogue("0Deseja coletar as frutas?") == true:
			outcome = %Execution.action()
			if outcome == true:
				await %DialogueManager.run_dialogue("0Circe coletou as frutas!")
				await %FruitTree.forage()
			else:
				await %DialogueManager.run_dialogue("0Circe se distraiu e não coletou as frutas...")
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue("1Talvez depois.")
	else:
		%FruitTree.ftree_already()

func _on_stone_item_click():
	%DialogueOptions.default_option_box()
	if await $Stone.click_dialogue("0Deseja minerar?") == true:
		outcome = %Execution.action()
		if outcome == true:
			await %DialogueManager.run_dialogue("0Circe minerou com sucesso!")
			await $Stone.mine_stone()
		else:
			await %DialogueManager.run_dialogue("0Circe se distraiu e não minerou...")
		%DayManager.date_change()
	else:
		await %DialogueManager.run_dialogue("0Talvez depois.")

func _on_spiderweb_item_click():
	await %Spiderweb.spiderweb_dialogue()

func _on_crops_item_click():
	%DialogueOptions.default_option_box()
	if %Crops.crop_current_status == "can plant":
		if await %Crops.click_dialogue("0Deseja plantar?") == true:
			outcome = %Execution.action()
			if outcome == true:
				await %DialogueManager.run_dialogue("0Circe plantou a semente!")
				await %Crops.plant_seed()
				$"Crops/Before Planting".hide()
				$"Crops/After Planting".show()
			else:
				await ("0Circe se distraiu...")
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue("0Talvez depois.")
	elif %Crops.crop_current_status == "planted":
		if await %Crops.click_dialogue("0Deseja regar?") == true:
			outcome = %Execution.action()
			if outcome == true:
				await %DialogueManager.run_dialogue("0Circe usou um feitiço e regou a planta!")
				await %Crops.water_plant()
			else:
				await %DialogueManager.run_dialogue("0Circe se distraiu...")
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue("0Talvez depois.")
	elif %Crops.crop_current_status == "watered":
		if await %Crops.click_dialogue("0Deseja colher?") == true:
			outcome = %Execution.action()
			if outcome == true:
				await %DialogueManager.run_dialogue("0Circe colheu os vegetais mágicos!")
				await %Crops.harvest()
				$"Crops/Before Planting".show()
			else:
				await %DialogueManager.run_dialogue("0Circe se distraiu...")
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue("0Talvez depois.")

func _on_workbench_item_click():
	%DialogueOptions.default_option_box()
	if %Inventory.inventory["staff"] > 0:
		$Workbench.workbench_already()
	elif %Inventory.inventory["stone"] < 2:
		$Workbench.workbench_lacking()
	else:
		if await $Workbench.click_dialogue($Workbench.workbench_d["prompt"]) == true:
			outcome = %Execution.action()
			if outcome == true:
				await %DialogueManager.run_dialogue($Workbench.workbench_d["success"])
				await $Workbench.repair()
			else:
				await %DialogueManager.run_dialogue($Workbench.workbench_d["fail"])
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue($Workbench.workbench_d["no"])

func _on_area_2d_input_event(viewport, event, shape_idx):
	pass # Replace with function body.

func _on_close_button_todolist_closed():
	pass # Replace with function body.


func _on_cauldron_item_click():
	var dialogue_prompt = ""
	var dialogue_success = "0Circe fez as poções com sucesso!"
	var dialogue_fail = "0Circe se distraiu..."
	var dialogue_no = "0Talvez depois."
	if %Inventory.inventory["vegetable"] < 2:
		$Cauldron.cauldron_lacking()
	else:
		if await $Cauldron.click_dialogue("0Deseja preparar poções?") == true:
			if %Alarm.is_active == true:
				$Cauldron.brew_success()
			else:
				$Cauldron.brew_fail()
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue("1Talvez depois.")
