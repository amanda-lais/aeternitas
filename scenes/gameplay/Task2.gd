extends "res://scenes/gameplay/task.gd"

func _ready():
	$Subtask1.hide()
	$Subtask2.hide()
	$Subtask3.hide()
	$Subtask4.hide()
	todolist_leveltwo()

func todolist_leveltwo():
	$Subtask1.show()
	$Subtask2.show()
	$Subtask3.show()
	$Subtask4.show()
