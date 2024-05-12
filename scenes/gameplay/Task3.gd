extends "res://scenes/gameplay/task.gd"

func _ready():
	$Subtask1.hide()
	$Subtask2.hide()
	todolist_leveltwo()

func todolist_leveltwo():
	$Subtask1.show()
	$Subtask2.show()
