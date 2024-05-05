extends Control

func set_option_box_text(box_text):
	box_text = "[center]" + box_text + "[/center]"
	%OptionText.text = box_text
