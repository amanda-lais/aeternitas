extends CanvasLayer

signal choose_op1
signal choose_op2
signal choose_op3

var option_amount

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_options()

func show_options(option_amount):
	%Overlay.show()
	%Option1.show()
	if option_amount == 2:
		%Option2.show()
	elif option_amount == 3:
		%Option2.show()
		%Option3.show()

func hide_options():
	%Overlay.hide()
	%Option1.hide()
	%Option2.hide()
	%Option3.hide()

func _on_option_1_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			choose_op1.emit()
			hide_options()

func _on_option_2_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			choose_op2.emit()
			hide_options()

func _on_option_3_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			choose_op3.emit()
			hide_options()
