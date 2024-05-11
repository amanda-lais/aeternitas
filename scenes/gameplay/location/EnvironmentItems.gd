extends CanvasGroup

var location_items = {}
var outcome

signal show_todolist
signal task_finished(task_id)
signal exp_gained(exp_points)

var default_todolist_dialogue = [
	"2Talvez tenha algo que possa marcar como feita na lista de tarefas.",
	"1Ah, é verdade!"
	]

func dialogue_on_click(dialogue):
	%DialogueManager.dialogue_list = dialogue
	%DialogueManager.start_dialogue()
	await %DialogueManager.dialogue_finished

func run_dialogue(dialogue):
	%DialogueManager.dialogue_list = [dialogue]
	%DialogueManager.start_dialogue()
	await %DialogueManager.dialogue_finished

func maybe_use_strategy():
	await run_dialogue("2Hmmm...")
	%DialogueOptions.set_option_box_text(1, "USAR ESTRATÉGIA")
	%DialogueOptions.set_option_box_text(2, "ENCERRAR DIA")
	%DialogueOptions.show_options(2)
	var option_number = await %DialogueOptions.option_chosen
	return option_number

func choose_strategy():
	%DialogueOptions.set_option_box_text(2, "LISTA DE TAREFAS")
	%DialogueOptions.set_option_box_text(3, "ENCERRAR DIA")
	var dialogue = [
		"2O que acha de usarmos uma estratégia agora, Circe?",
		"1Hmm... Pode ser. Vamos usar... uh, qual mesmo..."
		]
	await dialogue_on_click(dialogue)
	%DialogueOptions.set_option_box_text(1, "CALENDÁRIO")
	%DialogueOptions.show_options(3)
	var option_number = await %DialogueOptions.option_chosen
	return option_number

func remaining_choose_todolist(dialogue):
	await run_dialogue("2(Hmmm... Ainda seria possível usar a lista de tarefas...)")
	%DialogueOptions.set_option_box_text(1, "LISTA DE TAREFAS")
	%DialogueOptions.set_option_box_text(2, "ENCERRAR DIA")
	%DialogueOptions.show_options(2)
	var option_number = await %DialogueOptions.option_chosen
	if option_number == 1:
		await dialogue_on_click(dialogue)
		show_todolist.emit()
		exp_gained.emit(10)

func remaining_choose_calendar(dialogue):
	await run_dialogue("2(Hmmm... Ainda seria possível usar o calendário...)")
	%DialogueOptions.set_option_box_text(1, "CALENDÁRIO")
	%DialogueOptions.set_option_box_text(2, "ENCERRAR DIA")
	%DialogueOptions.show_options(2)
	var option_number = await %DialogueOptions.option_chosen
	if option_number == 1:
		await dialogue_on_click(dialogue)

func generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no):
	await run_dialogue(dialogue_prompt)
	%DialogueOptions.show_options(2)
	var option_number = await %DialogueOptions.option_chosen
	if option_number == 1:
		var i = 0
		#if dialogue_prompt == "0Deseja minerar?":
			#i += 1
			##$Stone.mine_sound()
		#elif dialogue_prompt == "0Deseja plantar?":
			#i += 1
			##%Crops.plant_sound()
		#elif dialogue_prompt == "0Deseja regar?":
			#i += 1
			##%Crops.water_sound()
		#elif dialogue_prompt == "0Deseja consertar o cetro?":
			#i += 1
		outcome = %Execution.action()
		if outcome == true:
			await run_dialogue(dialogue_success)
		else:
			await run_dialogue(dialogue_fail)
		return outcome
	elif option_number == 2:
		%DialogueOptions.cancel_audio()
		await run_dialogue(dialogue_no)

func _on_fruit_tree_item_click():
	%FruitTree.tree_sound()
	var dialogue_prompt = "0Deseja coletar as frutas?"
	var dialogue_success = "0Circe coletou as frutas!"
	var dialogue_fail = "0Circe se distraiu e não coletou as frutas..."
	var dialogue_no = "0Talvez depois."
	if %FruitTree.can_forage == 0:
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			await %FruitTree.forage()
			%DayManager.date_change()
	else:
		%FruitTree.ftree_already()

func _on_stone_item_click():
	var dialogue_prompt = "0Deseja minerar?"
	var dialogue_success = "0Circe minerou com sucesso!"
	var dialogue_fail = "0Circe se distraiu e não minerou..."
	var dialogue_no = "0Talvez depois."
	if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
		await $Stone.mine_stone()
		%DayManager.date_change()

func _on_spiderweb_item_click():
	await dialogue_on_click(%Spiderweb.dialogue)

func _on_crops_item_click():
	var dialogue_prompt = "0Deseja plantar?"
	var dialogue_success = "0Circe plantou a semente!"
	var dialogue_fail = "0Circe se distraiu..."
	var dialogue_no = "0Talvez depois."
	if %Crops.crop_current_status == "can plant":
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			%Crops.plant_seed()
			var option_number = await maybe_use_strategy()
			if option_number == 1:
				option_number = await choose_strategy()
				if option_number == 1:
					await dialogue_on_click(%Crops.dialogues["planted_calendar"])
					%Calendar.add_to_calendar("water_crop", %DayManager.today+1)
					await remaining_choose_todolist(default_todolist_dialogue)
				elif option_number == 2:
					await dialogue_on_click(default_todolist_dialogue)
					$"../../Tasks".show()
					exp_gained.emit(20)
					await _on_close_button_todolist_closed()
					await remaining_choose_calendar(%Crops.dialogues["planted_calendar"])
			%DialogueOptions.default_option_box()
			%DayManager.date_change()
			$"Crops/Before Planting".hide()
			$"Crops/After Planting".show()
	elif %Crops.crop_current_status == "planted":
		dialogue_prompt = "0Deseja regar?"
		dialogue_success = "0Circe usou um feitiço e regou a planta!"
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			%Crops.water_plant()
			var option_number = await maybe_use_strategy()
			if option_number == 1:
				option_number = await choose_strategy()
				if option_number == 1:
					await dialogue_on_click(%Crops.dialogues["planted_calendar"])
					%Calendar.add_to_calendar("harvest_crop", %DayManager.today+1)
					await remaining_choose_todolist(default_todolist_dialogue)
				elif option_number == 2:
					await dialogue_on_click(default_todolist_dialogue)
					$"../../Tasks".show()
					exp_gained.emit(20)
					await _on_close_button_todolist_closed()
					await remaining_choose_calendar(%Crops.dialogues["planted_calendar"])
			%DialogueOptions.default_option_box()
			%DayManager.date_change()
	elif %Crops.crop_current_status == "watered":
		dialogue_prompt = "0Deseja colher?"
		dialogue_success = "0Circe colheu os vegetais mágicos"
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			%Crops.harvest()
			var option_number = await maybe_use_strategy()
			if option_number == 1:
				print("blaaaaaaaa")
				#option_number = await choose_strategy()
				#if option_number == 1:
				#	await dialogue_on_click(%Crops.dialogues["planted_calendar"])
				#	await remaining_choose_todolist(default_todolist_dialogue)
				if await %ToDoList.tdl_or_end() == 1: #elif
					await dialogue_on_click(default_todolist_dialogue)
					$"../../Tasks".show()
					exp_gained.emit(20)
					await _on_close_button_todolist_closed()
					#await remaining_choose_calendar(%Crops.dialogues["planted_calendar"])
			%DialogueOptions.default_option_box()
			%DayManager.date_change()
			$"Crops/Before Planting".show()

func _on_workbench_item_click():
	var dialogue_prompt = $Workbench.workbench_d["prompt"]
	var dialogue_success = $Workbench.workbench_d["success"]
	var dialogue_fail = $Workbench.workbench_d["fail"]
	var dialogue_no = $Workbench.workbench_d["no"]
	if %Inventory.inventory["staff"] > 0:
		$Workbench.workbench_already()
	elif %Inventory.inventory["stone"] < 2:
		$Workbench.workbench_lacking()
	else:
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			%Inventory.add_to_inventory("stone", -2)
			%Inventory.add_to_inventory("staff", 1)
			var option_number = await maybe_use_strategy()
			if option_number == 1:
				await remaining_choose_todolist(default_todolist_dialogue)
				if option_number == 1:
					await dialogue_on_click(default_todolist_dialogue)
					$"../../Tasks".show()
					exp_gained.emit(20)
					await _on_close_button_todolist_closed()
		%DialogueOptions.default_option_box()
		%DayManager.date_change()

func _on_area_2d_input_event(viewport, event, shape_idx):
	pass # Replace with function body.

func _on_close_button_todolist_closed():
	pass # Replace with function body.


func _on_cauldron_item_click():
	var dialogue_prompt = "0Deseja preparar poções?"
	var dialogue_success = "0Circe fez as poções com sucesso!"
	var dialogue_fail = "0Circe se distraiu..."
	var dialogue_no = "0Talvez depois."
	if %Inventory.inventory["vegetable"] < 2:
		$Cauldron.cauldron_lacking()
	else:
		if %Alarm.is_active == true:
			if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
				%Inventory.add_to_inventory("vegetable", -2)
		else:
			run_dialogue("0A poção queimou e deu errado...")
			%Inventory.add_to_inventory("vegetable", -2)
