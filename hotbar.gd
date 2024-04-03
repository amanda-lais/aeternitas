extends Control

signal calendar_status(bool)
signal alarm_status(bool)
signal to_do_list_status(bool)
signal notepad_status(bool)
signal sticky_note_status(bool)

var calendar_active = false
var alarm_active = false
var to_do_list_active = false
var notepad_active = false
var sticky_note_active = false

func _ready():
	calendar_status.emit(calendar_active)
	alarm_status.emit(alarm_active)
	to_do_list_status.emit(to_do_list_active)
	notepad_status.emit(notepad_active)
	sticky_note_status.emit(sticky_note_active)

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	if index == 0:
		calendar_active = true
		calendar_status.emit(calendar_active)
	elif index == 1:
		alarm_active = true
		alarm_status.emit(alarm_active)
	elif index == 2:
		to_do_list_active = true
		to_do_list_status.emit(to_do_list_active)
	elif index == 3:
		notepad_active = true
		notepad_status.emit(notepad_active)
	elif index == 4:
		sticky_note_active = true
		sticky_note_status.emit(sticky_note_active)
