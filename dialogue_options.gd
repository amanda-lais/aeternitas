extends CanvasLayer

signal selection_started
signal selection_finished
signal option_chosen(option_number)

var box
var box_text
var option_amount

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_options()

func show_options(option_amount):
	selection_started.emit()
	%Option1.show()
	if option_amount == 2:
		%Option2.show()
	elif option_amount == 3:
		%Option2.show()
		%Option3.show()

func hide_options():
	selection_finished.emit()
	%Option1.hide()
	%Option2.hide()
	%Option3.hide()

func _on_option_1_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			option_chosen.emit(1)
			hide_options()

func _on_option_2_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			option_chosen.emit(2)
			hide_options()

func _on_option_3_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			option_chosen.emit(3)
			hide_options()
			
func set_option_box_text(box, box_text):
	if box == 1:
		%Option1.set_option_box_text(box_text)
	elif box == 2:
		%Option2.set_option_box_text(box_text)
	elif box == 3:
		%Option3.set_option_box_text(box_text)

func default_option_box():
	set_option_box_text(1, "SIM")
	set_option_box_text(2, "NÃO")
	set_option_box_text(3, "ESPERA")
