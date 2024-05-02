extends Sprite2D


var dialogue = ["0Examina teia de aranha", 
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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			%DialogueManager.dialogue_list = dialogue
			#%DialogueManager.dialogue_list = %EnvironmentItems.all_dialogues_at_location[get_name()]
			%DialogueManager.start_dialogue()
