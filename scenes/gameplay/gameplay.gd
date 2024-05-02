extends Node
@onready var btn_play = $MarginContainer/Control/VBoxContainer/PlayButton
@onready var btn_exit = $MarginContainer/Control/VBoxContainer/ExitButton

var elapsed = 0


# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	var cur_scene: Node = get_tree().current_scene
	print("Scene loaded: ", cur_scene.name, " (", cur_scene.scene_file_path, ")")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
	#btn_play.hide()
	#btn_exit.hide()
	#$Sprite2D.position = Game.size / 2


# `start()` is called after pre_start and after the graphic transition ends.
func start():
	print("gameplay.gd: start() called")


func _process(delta):
	elapsed += delta
	#$Sprite2D.position.x = Game.size.x / 2 + 150 * sin(2 * 0.4 * PI * elapsed)
	#$Sprite2D.position.y = Game.size.y / 2 + 100 * sin(2 * 0.2 * PI * elapsed)

func _on_PlayButton_pressed() -> void:
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
	Game.change_scene_to_file("res://scenes/gameplay/gameplay.tscn", params)


func _on_ExitButton_pressed() -> void:
	# gently shutdown the game
	var transitions = get_node_or_null("/root/Transitions")
	if transitions:
		transitions.fade_in({
			'show_progress_bar': false
		})
		await transitions.anim.animation_finished
		await get_tree().create_timer(0.3).timeout
	get_tree().quit()


func _on_exit_button_pressed():
	pass # Replace with function body.


func _on_area_2d_input_event(viewport, event, shape_idx):
	print("fruit tree :D")
