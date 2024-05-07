extends ColorRect

signal todolist_closed

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:#../../Tasks/
			$"../..".hide()
			todolist_closed.emit()
