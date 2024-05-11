extends "res://scenes/items/item.gd"

var ftree_d = {
	"prompt": "0Deseja coletar as frutas?",
	"success": "0Frutas coletadas!",
	"fail": "0Circe se distraiu...",
	"no": "0Talvez depois.",
	"already": "0Dê mais tempo para as frutas crescerem!",
	}

var can_forage = 0
var amount

func forage():
	tree_sound()
	if can_forage == 0:
		can_forage += 1
	if %ToDoList.is_active == true:
		amount = 3
	else:
		amount = randi_range(1, 3)
	audio_collect()
	await %DialogueManager.run_dialogue("0" + str(int(amount)) + " fruta(s) adicionada(s) ao inventário!")
	%Inventory.add_to_inventory("fruit", amount)
	await %EnvironmentStrategies.choose_strategy_3(
		true, true, false, "fruit", "forage_again", %DayManager.today+2)

func tree_sound():
	$"../../../Inventory/02_tree_rustling_3_wav".play()

func ftree_already():
	audio_cant_do()
	await %DialogueManager.run_dialogue(ftree_d["already"])
