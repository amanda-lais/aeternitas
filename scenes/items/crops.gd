extends "res://scenes/items/item.gd"

signal date_update

var crop_status
var crop_name
var day_planted = 0
var day_goes_bad = 0
var day_needs_water = 0
var day_can_harvest = 0
var is_watered = false
var is_harvested = false

#receives signal that date has changed
func temporari():
	pass

func crops_dict():
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
	#day_planted = %DayManager.today
	day_needs_water = day_planted + 2
	date_update.emit()

func water_plant():
	is_watered = true
	day_can_harvest = %DayManager.today + 1
	date_update.emit()

func harvest():
	day_can_harvest = 100
	%Inventory.vegetable_amount += 1
	date_update.emit()

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
