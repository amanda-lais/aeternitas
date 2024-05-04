extends Control

signal new_day

var game_days = {}
var today
var today_info

var alarm_clicked_today
var to_do_list_opened_today
var calendar_opened_today
var calendar_upcoming_checked_today

# Called when the node enters the scene tree for the first time.
func _ready():
	today = 1

func day_reset():
	alarm_clicked_today = false
	to_do_list_opened_today = false
	calendar_opened_today = false
	calendar_upcoming_checked_today = false

func date_change():
	if today != 8:
		today += 1
		day_reset()
		load_new_day()

func load_new_day():
	new_day.emit()
