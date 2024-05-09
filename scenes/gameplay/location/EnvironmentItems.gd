extends CanvasGroup

var location_items = {}
var outcome

signal show_todolist
signal task_finished(task_id)

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
	%DialogueOptions.set_option_box_text(1, "CALENDÁRIO")
	%DialogueOptions.set_option_box_text(2, "LISTA DE TAREFAS")
	%DialogueOptions.set_option_box_text(3, "ENCERRAR DIA")
	var dialogue = [
		"2O que acha de usarmos uma estratégia agora, Circe?",
		"1Hmm... Pode ser. Vamos usar... uh, qual mesmo..."
		]
	await dialogue_on_click(dialogue)
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

func remaining_choose_calendar(dialogue):
	await run_dialogue("2(Hmmm... Ainda seria possível usar o calendário...)")
	%DialogueOptions.set_option_box_text(1, "CALENDÁRIO")
	%DialogueOptions.set_option_box_text(2, "ENCERRAR DIA")
	%DialogueOptions.show_options(2)
	var option_number = await %DialogueOptions.option_chosen
	if option_number == 1:
		await dialogue_on_click(dialogue)

# Called when the node enters the scene tree for the first time.
func _ready():
	%FruitTree.can_forage = 0
	%Crops.crops_dict()

func generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no):
	await run_dialogue(dialogue_prompt)
	%DialogueOptions.show_options(2)
	var option_number = await %DialogueOptions.option_chosen
	if option_number == 1:
		outcome = %Execution.action()
		if outcome == true:
			await run_dialogue(dialogue_success)
		else:
			await run_dialogue(dialogue_fail)
		return outcome
	elif option_number == 2:
		await run_dialogue(dialogue_no)

func _on_fruit_tree_item_click():
	var dialogue_prompt = "0Deseja coletar as frutas?"
	var dialogue_success = "0Circe coletou as frutas!"
	var dialogue_fail = "0Circe se distraiu e não coletou as frutas..."
	var dialogue_no = "0Talvez depois."
	if %FruitTree.can_forage == 0:
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			%FruitTree.forage()
			var amount
			if %ToDoList.is_active == true:
				amount = 3
			else:
				amount = randi_range(1, 3)
			await run_dialogue("0" + str(int(amount)) + " fruta(s) adicionada(s) ao inventário!")
			%Inventory.add_to_inventory("fruit", amount)
			%Calendar.add_to_calendar("forage_again", %DayManager.today+2)
			%DayManager.date_change()
	else:
		await run_dialogue(%FruitTree.dialogue)

func _on_stone_item_click():
	var dialogue_prompt = "0Deseja minerar?"
	var dialogue_success = "0Circe minerou com sucesso!"
	var dialogue_fail = "0Circe se distraiu e não minerou..."
	var dialogue_no = "0Talvez depois."
	if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
		%Inventory.add_to_inventory("stone", 2)
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
			%Calendar.add_to_calendar("water_crop", %DayManager.today+1)
			%Inventory.add_to_inventory("seed", -1)
			var option_number
			option_number = await maybe_use_strategy()
			if option_number == 1:
				option_number = await choose_strategy()
				if option_number == 1:
					await dialogue_on_click(%Crops.dialogues["planted_calendar"])
					await remaining_choose_todolist(default_todolist_dialogue)
				elif option_number == 2:
					await dialogue_on_click(default_todolist_dialogue)
					show_todolist.emit()
					await _on_close_button_todolist_closed()
					await remaining_choose_calendar(%Crops.dialogues["planted_calendar"])
			%DialogueOptions.default_option_box()
			%DayManager.date_change()
	elif %Crops.crop_current_status == "planted":
		dialogue_prompt = "0Deseja regar?"
		dialogue_success = "0Circe regou a planta!"
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			%Crops.water_plant()
			%Calendar.add_to_calendar("harvest_crop", %DayManager.today+1)
			%Inventory.add_to_inventory("water", -1)
			%DayManager.date_change()
	elif %Crops.crop_current_status == "watered":
		dialogue_prompt = "0Deseja colher?"
		dialogue_success = "0Circe colheu os vegetais mágicos"
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			%Crops.harvest()
			%Inventory.add_to_inventory("vegetable", 2)
			%DayManager.date_change()

func _on_workbench_item_click():
	var dialogue_prompt = "0Deseja consertar o cetro?"
	var dialogue_success = "0Circe consertou o cetro com sucesso!"
	var dialogue_fail = "0Circe se distraiu..."
	var dialogue_no = "0Talvez depois."
	if %Inventory.inventory["stone"] < 2:
		run_dialogue("0Circe não tem material o suficiente...")
	else:
		if %Inventory.inventory["staff"] != 0:
			run_dialogue("1...? Eu já consertei o cetro.")
		else:
			if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
				%Inventory.add_to_inventory("stone", -2)
				%Inventory.add_to_inventory("staff", 1)

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
		run_dialogue("0Circe não tem vegetais mágicos o suficiente...")
	else:
		if %Alarm.is_active == true:
			if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
				%Inventory.add_to_inventory("vegetable", -2)
		else:
			run_dialogue("0A poção deu errado...")
			%Inventory.add_to_inventory("vegetable", -2)
