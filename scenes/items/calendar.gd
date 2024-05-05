extends "res://scenes/items/strategy.gd"

var today
var tomorrow
var coming_up
var calendar_checked_today
#var previously_checked_today
var event_today

func check_day_x(day_x):
	#day_x[rng] -= 0.07
	pass

func chronos_reminders_when_unrelated():
	if calendar_checked_today == true && event_today == true:
		pass

