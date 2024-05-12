extends CanvasLayer

signal selection_started
signal selection_finished
signal option_chosen(option_number)

var box
var box_text
var option_amount
var before_shake

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_options()

func cancel_audio():
	$"Fantasy_UI cancel".play()

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
			$"../DialogueManager/Click_15 Halftone".play()
			hide_options()

func _on_option_2_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			option_chosen.emit(2)
			$"../DialogueManager/Click_15 Halftone".play()
			hide_options()

func _on_option_3_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			option_chosen.emit(3)
			$"../DialogueManager/Click_15 Halftone".play()
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

func generic_branch(dialogue, box_amount, box1, box2, box3=""):
	set_option_box_text(1, box1)
	set_option_box_text(2, box2)
	set_option_box_text(3, box3)
	await %DialogueManager.dialogue_on_click(dialogue)
	show_options(box_amount)
	var option_number = await self.option_chosen
	return option_number

func _on_option_1_mouse_entered():
	before_shake = $Option1/OptionBox/OptionText.text
	$"../../Forest/Mouse Hover".play()
	$Option1/OptionBox/OptionText.text = "[shake]" + $Option1/OptionBox/OptionText.text + "[/shake]"

func _on_option_2_mouse_entered():
	before_shake = $Option2/OptionBox/OptionText.text
	$"../../Forest/Mouse Hover".play()
	$Option2/OptionBox/OptionText.text = "[shake]" + $Option2/OptionBox/OptionText.text + "[/shake]"

func _on_option_3_mouse_entered():
	before_shake = $Option3/OptionBox/OptionText.text
	$"../../Forest/Mouse Hover".play()
	$Option3/OptionBox/OptionText.text = "[shake]" + $Option3/OptionBox/OptionText.text + "[/shake]"

func _on_option_1_mouse_exited():
	$Option1/OptionBox/OptionText.text = before_shake

func _on_option_2_mouse_exited():
	$Option2/OptionBox/OptionText.text = before_shake

func _on_option_3_mouse_exited():
	$Option3/OptionBox/OptionText.text = before_shake
