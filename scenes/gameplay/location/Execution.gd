extends Node

signal score_earned(score_points)
signal exp_earned(exp_points)

var general_modifier
var specific_modifier
var rng_edf
var score_points
var exp_points
var inventory
var result

func calc_specific_modifier(item):
	if item.is_active_crucial_strategy == true:
		pass
	else:
		pass
	if item.is_task_chunkable:
		pass
	if item.is_mess_active:
		if item.extra_mess_impact:
			pass

func calc_general_modifier(strategy,item):
	if strategy.is_active_bonus:
		pass
	if !item.extra_mess_impact:
		pass

func add_to_inventory(item):
	pass

func calc_mmultiplier(checks):
	var multiplier = 1 - checks
	pass

func check_sf(vrng, multiplier):
	result = vrng * multiplier

func succeeds(experience, item, task, strategy):
	score_points = task.score_points
	add_to_inventory(item)
	task.task_done = true
	exp_points = experience
	score_earned.emit(score_earned)
	exp_earned.emit(exp_points)
	#date_change()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
