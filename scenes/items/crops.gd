extends "res://scenes/items/item.gd"

var crop_status
var crop_name
var day_planted
var day_goes_bad
var day_needs_water
var is_watered

#receives signal that date has changed
func temporari():
	

# Called when the node enters the scene tree for the first time.
func _ready():
	crop_status = {
		"crop_name": crop_name,
		"day_planted": day_planted,
		"day_goes_bad": day_goes_bad,
		"day_needs_water": day_needs_water,
		"is_watered": is_watered
	}
