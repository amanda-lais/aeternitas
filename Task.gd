extends Control

signal score_task_checked_off

var task = {}
var task_name = ""
var task_done = 0
var pending_check = 0
var is_chunked = 0
var can_break_down = -1
var task_parent = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	task_name = get_name()
	task = {
		"task_name": task_name,
		"task_done": task_done,
		"pending_check": pending_check,
		"is_chunked": is_chunked,
		"can_break_down": can_break_down,
		"task_parent": task_parent
	}
	#$"..".to_do_list[task_name] = {task_name: task}

func on_task_click():
	if pending_check == true:
		pass
	if task_done == true:
		pass
	if $"..".level >= 2:
		if is_chunked == true:
			pass
		if can_break_down == true:
			pass
	score_task_checked_off.emit()

func task_completed():
	task_done = true
	pending_check = true

func task_checked_off():
	pending_check = false

func break_down_task():
	if is_chunked == false:
		is_chunked = true
