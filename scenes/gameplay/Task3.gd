extends "res://scenes/gameplay/task.gd"

func _ready():
	$Subtask1.hide()
	todolist_leveltwo()

func todolist_leveltwo():
	$Subtask1.show()
