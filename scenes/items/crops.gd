extends "res://scenes/items/item.gd"

signal date_update

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
var crop_current_status

#receives signal that date has changed
func temporari():
	pass

func crops_dict():
	crop_current_status = "can plant"
	day_planted = 0
	crop_status = {
		"crop_name": crop_name,
		"day_planted": day_planted,
		"day_needs_water": day_needs_water,
		"day_can_harvest": day_can_harvest,
		"is_watered": is_watered,
		"is_harvested": is_harvested
	}

func can_water(today):
	if today >= day_needs_water:
		if is_watered == false:
			return true
		return false
	return false

func can_harvest(today):
	if today >= day_can_harvest:
		return true
	return false

func plant_seed():
	crop_current_status = "planted"

func water_plant():
	crop_current_status = "watered"

func harvest():
	crop_current_status = "can plant"
	%Inventory.vegetable_amount += 1

func date_updated():
	date_update.emit()

func look_at_checklist():
	#checklist.something(crops)
	#what is needed
	#how much
	#lowers crop modifiers
	#to do list exp
	pass

func succeeds_step(option):
	if option == "calendar":
		#sets goes_bad_date
		#sets harvestable_date
		pass
	elif option == "to do list":
		#check off the task
		#to do list exp points
		pass
