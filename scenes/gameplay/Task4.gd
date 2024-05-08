extends "res://scenes/gameplay/task.gd"

func _ready():
	$Subtask2.hide()
	$Subtask3.hide()
	todolist_leveltwo()

func todolist_leveltwo():
	$Subtask2.show()
	$Subtask3.show()
