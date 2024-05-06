extends ColorRect

signal blackout_clicked

func _ready():
	self.hide()

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			blackout_clicked.emit()
