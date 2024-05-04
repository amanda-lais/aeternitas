extends Control

var day_info
var days_date
var days_rng_weight
var has_alarm
var today_fruit
var calendar_events
var crops_today

func _ready():
	days_date = str(get_name())
	day_info = {
		"days_date": days_date[3],
		"days_rng_weight": days_rng_weight,
		"has_alarm": has_alarm,
		"calendar_events": calendar_events,
		"today_fruit": today_fruit,
		"crops_today": crops_today,
	}
	$"../..".game_days[days_date] = day_info
