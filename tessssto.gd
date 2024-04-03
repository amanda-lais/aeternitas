extends Node2D

var dialogue_list = ["0Examina teia de aranha", 
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
	%Dialogue.start_dialogue(dialogue_list)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
