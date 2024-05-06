extends ColorRect

func _ready():
	self.hide()

func _on_dialogue_manager_dialogue_started():
	self.show()

func _on_dialogue_options_selection_started():
	self.show()

func _on_dialogue_manager_dialogue_finished():
	self.hide()

func _on_dialogue_options_option_chosen(option_number):
	self.hide()
