extends Control

var new = []

var task_list = {}
var subtask_node = {}

var to_do_list
var to_do_list_exp
var to_do_list_checked_today
var to_do_list_level
signal todolist_closed
signal todolist_clicked

signal score_gained(score)
#var checklist_checks_pending

# Called when the node enters the scene tree for the first time.
#func _ready():
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func _on_environment_items_show_todolist():
	$ColorRect.show()

func _on_close_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			todolist_closed.emit()
			$ColorRect.hide()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$ColorRect.show()
			$"Darkworld PaperDocument2".play()

func _on_color_rect_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			todolist_clicked.emit()
			if len(new)>0:
				subtask_node[new[0]].check_task()
				score_gained.emit(10)
				new.pop_front()

func _on_inventory_task_finished(task_id):
	task_list[task_id] = true
	new.append(task_id)
	#Main tasks
	#Task 1 - Food
	if task_id == "GetFood":
		subtask_node[task_id] = get_node("ColorRect/Task1")
	#Task 2 - Potion Brewing
	elif task_id == "StockPotions":
		subtask_node[task_id] = get_node("ColorRect/Task2")
	#Task 3 - Repair Staff
	elif task_id == "RepairStaff":
		subtask_node[task_id] = get_node("ColorRect/Task3")
		subtask_node["StaffRepaired"] = get_node("ColorRect/Task3/Subtask2")
		subtask_node["RepairedStaff"] = get_node("ColorRect/Task4/Subtask2")
		new.append("StaffRepaired")
		new.append("RepairedStaff")
		task_list["StaffRepaired"] = true
		task_list["RepairedStaff"] = true
	#Task 4 - Recharge Staff
	#elif task_id == "ChargeStaff":
	#	subtask_node[task_id] = get_node("ColorRect/Task4")
	#Subtasks
	#Task 3 - Repair
	elif task_id == "AcquireRock":
		subtask_node[task_id] = get_node("ColorRect/Task3/Subtask1")
	#elif task_id == "RepairStaff":
	#	subtask_node[task_id] = get_node("ColorRect/Task3/Subtask2")
	#Task 4 - Recharge
	elif task_id == "MoonExposure":
		subtask_node[task_id] = get_node("ColorRect/Task4/Subtask3")
		subtask_node["ChargeStaff"] = get_node("ColorRect/Task4")
		new.append("ChargeStaff")
		task_list["ChargeStaff"] = true
	#Task 2 - Potion Brewing
	elif task_id == "PlantSeed":
		subtask_node[task_id] = get_node("ColorRect/Task2/Subtask1")
	elif task_id == "WaterCrop":
		subtask_node[task_id] = get_node("ColorRect/Task2/Subtask2")
	elif task_id == "HarvestCrop":
		subtask_node[task_id] = get_node("ColorRect/Task2/Subtask3")
	elif task_id == "BrewPotion":
		subtask_node[task_id] = get_node("ColorRect/Task2/Subtask4")
