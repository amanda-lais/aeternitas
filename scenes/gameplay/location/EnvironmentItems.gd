extends CanvasGroup

var all_dialogues_at_location = {}
signal test_activity

var location_items = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	#starts dictionary
	all_dialogues_at_location['fruit_tree'] = [""]
	all_dialogues_at_location['stone'] = [""]
	all_dialogues_at_location['crops'] = [""]
	all_dialogues_at_location['workbench'] = [""]
	all_dialogues_at_location['spiderweb'] = [""]
	all_dialogues_at_location['moon'] = [""]
	all_dialogues_at_location['spiderweb'] = ["0Examina teia de aranha", 
"1Uma teia de aranha!", 
"1Hmm, a aranha que fez isso deve estar por aqui...", 
"2... (sprite incomodado)", 
"0Circe examina a região", 
"1Aww... Sem sinal dela...", 
"2(suspira aliviada)", 
"1? O que foi, Chronos?", 
"2Eu não gosto de aranhas...", 
"1Poxa, sério?", 
"1Mas aranhas são tão fofas! E legais!", 
"2...Circe, você sabe que eu sou uma borboleta, certo?", 
'1E "aranhas comem borboletas", blá blá blá", certo?', 
"2Sim! Exatamente!", 
"1Meh. Se eu fosse uma borboleta ainda acharia elas legais.", 
"2...", 
"2Okay..."]

func _on_fruit_tree_item_click():
	dialogue_on_click("fruit_tree")

func _on_stone_item_click():
	dialogue_on_click("stone")

func _on_spiderweb_item_click():
	dialogue_on_click("spiderweb")
	test_activity.emit()
	print(location_items)

func _on_crops_item_click():
	dialogue_on_click("crops")

func _on_moon_item_click():
	dialogue_on_click("moon")

func _on_workbench_item_click():
	dialogue_on_click("workbench")

func dialogue_on_click(item_clicked):
	%DialogueManager.dialogue_list = all_dialogues_at_location[item_clicked]
	%DialogueManager.start_dialogue()
