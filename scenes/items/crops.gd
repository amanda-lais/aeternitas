extends "res://scenes/items/item.gd"

var dialogues = {
	"planted_todolist": [],
	"planted_calendar": [
		"2...podemos usar o calendário, talvez?",
		"1Isso, isso! Para... colocar a data para regar e colher, eu acho.",
		"2Perfeito.",
		"2Então, quais datas seriam?",
		"1Bem, esses vegetais são bem simples. Outros podem ser mais difíceis de cuidar, mas...",
		"1Para estes, basta regar amanhã. E já posso colher 1 dia depois de regar!",
		"2Oh. E eles vão estragar se você esquecer de regar ou plantar...?",
		"1Não, não.",
		"1Justo por serem os vegetais mágicos mais duráveis do mundo que são os mais simples de cultivar.",
		"1...então, vou só colocar no calendário que posso regá-los amanhã.",
		"2Mmhm."
		],
	"watered_calendar": [
		"2...podemos usar o calendário, talvez?",
		"1Isso, isso! Para... colocar a data para a colheita.",
		"2Perfeito.",
		"2Então, qual data seria?",
		"1Bem, esses vegetais são bem simples. Outros podem ser mais difíceis de cuidar, mas...",
		"1Para estes, eu posso colher 1 dia depois de regar. Então amanhã já estão prontos!",
		"2Oh. E eles vão estragar se você esquecer de regar...? Ou então, se demorar demais para colhê-los?",
		"1Não, não.",
		"1Justo por serem os vegetais mágicos mais duráveis do mundo que são os mais simples de cultivar.",
		"1...então, vou só colocar no calendário que posso colher amanhã.",
		"2Mmhm."
		]
	}

var crop_status
var crop_name
var day_planted = 0
var day_goes_bad = 0
var day_needs_water = 0
var day_can_harvest = 0
var is_watered
var is_harvested
var crop_current_status = "can plant"

#func crops_dict():
	#day_planted = 0
	#crop_status = {
		#"crop_name": crop_name,
		#"day_planted": day_planted,
		#"day_needs_water": day_needs_water,
		#"day_can_harvest": day_can_harvest,
		#"is_watered": is_watered,
		#"is_harvested": is_harvested
	#}

func plant_seed():
	audio_plant()
	crop_current_status = "planted"
	%Inventory.add_to_inventory("seed", -1)
	await %EnvironmentStrategies.choose_strategy_3(
		true, true, false, crop_current_status, "water_crop", %DayManager.today+1)
	%DialogueOptions.default_option_box()

func water_plant():
	audio_water()
	crop_current_status = "watered"
	%Inventory.add_to_inventory("water", -1)
	await %EnvironmentStrategies.choose_strategy_3(
		true, true, false, "watered", "can_harvest", %DayManager.today+1)
	%DialogueOptions.default_option_box()

func harvest():
	crop_current_status = "can plant"
	%Inventory.add_to_inventory("vegetable", 2)
	audio_collect()
	$Pumpkin.hide()
	$"Before Planting".show()
	$"After Planting".hide()
	await %EnvironmentStrategies.choose_strategy_3(
		false, true, false)

func audio_water():
	$"../../../Inventory/Wave Attack 1".play()

func audio_plant():
	$"../../../Inventory/Dirt Walk 2".play()
