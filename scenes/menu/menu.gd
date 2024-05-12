extends Control

@onready var btn_play = $MarginContainer/Control/VBoxContainer/PlayButton
@onready var btn_exit = $MarginContainer/Control/VBoxContainer/ExitButton

var before_shake

func _ready():
	# needed for gamepads to work
	btn_play.grab_focus()
	if OS.has_feature('web'):
		btn_exit.queue_free() # exit button dosn't make sense on HTML5

func _on_play_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var params = {
				"show_progress_bar": true,
				"a_number": 10,
				"a_string": "Ciao!",
				"an_array": [1, 2, 3, 4],
				"a_dict": {
					"name": "test",
					"val": 15
				},
			}
			Game.change_scene_to_file("res://scenes/gameplay/game.tscn", params)


func _on_exit_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# gently shutdown the game
			var transitions = get_node_or_null("/root/Transitions")
			if transitions:
				transitions.fade_in({
					'show_progress_bar': false
				})
				await transitions.anim.animation_finished
				await get_tree().create_timer(0.3).timeout
			get_tree().quit()


func _on_play_button_mouse_entered():
	before_shake = $MarginContainer/Control/VBoxContainer/PlayButton/RichTextLabel.text
	$"Mouse Hover".play()
	$MarginContainer/Control/VBoxContainer/PlayButton/RichTextLabel.text = "[shake]" + before_shake + "[/shake]"


func _on_exit_button_mouse_entered():
	before_shake = $MarginContainer/Control/VBoxContainer/ExitButton/RichTextLabel.text
	$"Mouse Hover".play()
	$MarginContainer/Control/VBoxContainer/ExitButton/RichTextLabel.text = "[shake]" + before_shake + "[/shake]"


func _on_play_button_mouse_exited():
	$MarginContainer/Control/VBoxContainer/PlayButton/RichTextLabel.text = before_shake


func _on_exit_button_mouse_exited():
	$MarginContainer/Control/VBoxContainer/ExitButton/RichTextLabel.text = before_shake
