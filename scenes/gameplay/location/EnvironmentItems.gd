extends CanvasGroup

var all_dialogues_at_location = {}
var outcome
signal test_activity

var location_items = {}

func run_dialogue(dialogue):
	%DialogueManager.dialogue_list = [dialogue]
	%DialogueManager.start_dialogue()

# Called when the node enters the scene tree for the first time.
func _ready():
	%FruitTree.can_forage = 0
	%Crops.crops_dict()
	#starts dictionary
	all_dialogues_at_location['crops'] = [""]
	all_dialogues_at_location['workbench'] = [""]
	all_dialogues_at_location['spiderweb'] = [""]
	all_dialogues_at_location['moon'] = [""]
	all_dialogues_at_location['spiderweb'] = [""]

func generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no):
	run_dialogue(dialogue_prompt)
	await %DialogueManager.dialogue_finished
	%DialogueOptions.show_options(2)
	var option_number = await %DialogueOptions.option_chosen
	if option_number == 1:
		outcome = %Execution.action()
		if outcome == true:
			run_dialogue(dialogue_success)
		else:
			run_dialogue(dialogue_fail)
		await %DialogueManager.dialogue_finished
		%DayManager.date_change()
		return outcome
	elif option_number == 2:
		run_dialogue(dialogue_no)
		await %DialogueManager.dialogue_finished

func _on_fruit_tree_item_click():
	var dialogue_prompt = "0Deseja coletar as frutas?"
	var dialogue_success = "0Circe coletou as frutas!"
	var dialogue_fail = "0Circe se distraiu e não coletou as frutas..."
	var dialogue_no = "0Talvez depois."
	if %FruitTree.can_forage == 0:
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			%FruitTree.forage()
			%Inventory.fruit_amount += 3
	else:
		run_dialogue(%FruitTree.dialogue)
	await %DialogueManager.dialogue_finished

func _on_stone_item_click():
	var dialogue_prompt = "0Deseja minerar?"
	var dialogue_success = "0Circe minerou com sucesso!"
	var dialogue_fail = "0Circe se distraiu e não minerou..."
	var dialogue_no = "0Talvez depois."
	if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
		%Inventory.stone_amount += 1

func _on_spiderweb_item_click():
	dialogue_on_click(%Spiderweb.dialogue)

func _on_crops_item_click():
	var dialogue_prompt = "0Deseja plantar?"
	var dialogue_success = "0Circe plantou a semente!"
	var dialogue_fail = "0Circe se distraiu..."
	var dialogue_no = "0Talvez depois."
	if %Crops.day_planted == 0:
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			%Crops.plant_seed()
			%Crops.day_planted = %DayManager.today
	elif %Crops.can_water(%DayManager.today) == true:
		dialogue_prompt = "0Deseja regar?"
		dialogue_success = "0Circe regou a planta!"
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			%Crops.water_plant()
	elif %Crops.can_harvest(%DayManager.today) == true:
		dialogue_prompt = "0Deseja colher?"
		dialogue_success = "0Circe colheu os vegetais mágicos"
		if await generic_click_dialogue(dialogue_prompt, dialogue_success, dialogue_fail, dialogue_no) == true:
			%Crops.harvest()

func _on_moon_item_click():
	dialogue_on_click("moon")

func _on_workbench_item_click():
	dialogue_on_click("workbench")

func dialogue_on_click(item_clicked):
	%DialogueManager.dialogue_list = item_clicked
	#%DialogueManager.dialogue_list = all_dialogues_at_location[item_clicked]
	%DialogueManager.start_dialogue()

func _on_area_2d_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
