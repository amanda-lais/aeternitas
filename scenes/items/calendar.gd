extends "res://scenes/items/strategy.gd"

var full_moon_day = 5

var today
var tomorrow
var coming_up
var calendar_checked_today
#var previously_checked_today
var event_today
var calendar_events = {}
var day_list = ["","",[],[],[],[],[],[],[]]

func add_to_calendar(event, day):
	calendar_events[event] = day

func check_day_x(day_x):
	#day_x[rng] -= 0.07
	pass

func chronos_reminders_when_unrelated():
	if calendar_checked_today == true && event_today == true:
		pass

