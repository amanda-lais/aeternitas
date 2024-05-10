extends Control

func check_task():
	%CheckTaskSound.play()
	$Description.text = "[s]" + $Description.text + "[/s]"
	$Checkbox/Check.show()

func add_subtask1():
	$Subtask1.show()

func add_subtask2():
	$Subtask2.show()

func add_subtask3():
	$Subtask3.show()

func add_subtask4():
	$Subtask4.show()
