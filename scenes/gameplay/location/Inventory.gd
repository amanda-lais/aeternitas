extends Node

var inventory = {
	"stone": 0,
	"fruit": 0,
	"potion":0,
	"vegetable": 0,
	"seed": 2,
	"staff": 0,
	"water": 1
	}
	
signal score_gained(score)
signal task_finished(task_id)

func add_to_inventory(item, amount):
	inventory[item] += amount
	if item == "stone":
		if stone_check(inventory[item]) == true:
			task_finished.emit("AcquireRock")
			score_gained.emit(50)
	elif item == "fruit":
		if fruit_check(inventory[item]) == true:
			task_finished.emit("GetFood")
			score_gained.emit(150)
	elif item == "seed" and amount < 0:
		task_finished.emit("PlantSeed")
		score_gained.emit(50)
	elif item == "water" and amount < 0:
		task_finished.emit("WaterCrop")
		score_gained.emit(50)
	elif item == "vegetable" and amount > 0:
		task_finished.emit("HarvestCrop")
		score_gained.emit(50)
	elif item == "vegetable" and amount < 0:
		if %Alarm.is_active == true:
			%Inventory.add_to_inventory("potion", 1)
			score_gained.emit(250)
	elif item == "staff" and inventory[item] == 1:
		task_finished.emit("RepairStaff")
		score_gained.emit(200)
	elif item == "staff" and inventory[item] == 2:
		task_finished.emit("MoonExposure")
		score_gained.emit(250)
	
func stone_check(stone_amount):
	if stone_amount >= 1:
		return true
	return false

func fruit_check(fruit_amount):
	if fruit_amount >= 3:
		return true
	return false

func _on_day_manager_full_moon():
	if %Alarm.is_active == true and %Calendar.is_active == true:
		add_to_inventory("staff", 1)
