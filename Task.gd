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
	$"..".to_do_list[task_name] = {task_name: task}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
