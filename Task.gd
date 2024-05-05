extends Control

var task = {}
var task_name = ""
var task_done = 0
var pending_check = 0
var is_chunked = 0
var can_break_down = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	task_name = get_name()
	task = {
		"task_name": task_name,
		"task_done": task_done,
		"pending_check": pending_check,
		"is_chunked": is_chunked,
		"can_break_down": can_break_down
	}
	#$"..".to_do_list[task_name] = {task_name: task}

func task_completed():
	task_done = true
	pending_check = true

func task_checked_off():
	pending_check = false

func break_down_task():
	if is_chunked == false:
		is_chunked = true
