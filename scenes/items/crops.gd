extends "res://scenes/items/item.gd"

var crop_status
var crop_name
var day_planted
var day_goes_bad
var day_needs_water
var is_watered

#receives signal that date has changed
func temporari():
	pass

func crops_dict():
	crop_status = {
		"crop_name": crop_name,
		"day_planted": day_planted,
		"day_goes_bad": day_goes_bad,
		"day_needs_water": day_needs_water,
		"is_watered": is_watered
	}

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
