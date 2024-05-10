extends Control

func set_option_box_text(box_text):
	box_text = "[center]" + box_text + "[/center]"
	$OptionBox/OptionText.text = box_text
