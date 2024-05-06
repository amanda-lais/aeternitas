extends "res://scenes/items/item.gd"

var dialogue = "0Dê mais tempo para as frutas crescerem!"
var confirmation_dialogue = "0Deseja coletar as frutas?"
var confirmation_dialogue_yes = "0Frutas coletadas!"
var confirmation_dialogue_no = "0Talvez depois."

var can_forage
var todays_fruit

func forage():
	if can_forage == 0:
		can_forage += 1
		#something.add_to_inventory

func harvest():
	#SOMETHING.add_to_inventory(todays_fruit)
	pass
