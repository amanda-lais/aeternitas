extends Node

signal score_earned(score_points)
signal exp_earned(exp_points)

var rng
var general_modifier
var specific_modifier
var rng_edf
var score_points
var exp_points
var inventory

func action(cal_crucial=false, tdl_crucial=false, alarm_crucial=false):
	var pos_modifier = 0
	var neg_modifier = 0
	pos_modifier += tdl_modifier_calc()
	pos_modifier += cal_modifier_calc()
	pos_modifier += alarm_modifier_calc()
	neg_modifier += mess_modifier_calc()
	var outcome = randi_range(neg_modifier, 100-pos_modifier)
	if outcome > 60:
		return false #fail
	else:
		return true #success

func mess_modifier_calc():
	var modifier = 0
	if %Mess.is_active == true:
		modifier += 30
	return modifier

func cal_modifier_calc(cal_crucial = false):
	var modifier = 0
	if %Calendar.is_active == true and cal_crucial==true:
		modifier += 30
	elif %Calendar.is_active == true and cal_crucial==false:
		modifier += 15
	return modifier

func tdl_modifier_calc(tdl_crucial = false):
	var modifier = 0
	if %ToDoList.is_active == true and tdl_crucial==true:
		modifier += 30
	elif %ToDoList.is_active == true and tdl_crucial==false:
		modifier += 15
	return modifier

func alarm_modifier_calc(alarm_crucial = false):
	var modifier = 0
	if %Alarm.is_active == true and alarm_crucial==true:
		modifier += 30
	elif %Alarm.is_active == true and alarm_crucial==false:
		modifier += 15
	return modifier

func generate_rng(min, max):
	rng = RandomNumberGenerator.new()
	var my_random_number = rng.randf_range(0, 100)
	return my_random_number

func succeeds(experience, item, task, strategy):
	score_points = task.score_points
	#add_to_inventory(item)
	task.task_done = true
	exp_points = experience
	score_earned.emit(score_earned)
	exp_earned.emit(exp_points)
	#date_change()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
