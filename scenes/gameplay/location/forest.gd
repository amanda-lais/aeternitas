extends Node2D

signal score_gained



# Reference to the Sprite2D nodes
#@onready var main_sprite = %SpiderwebMainSprite
#@onready var hover_sprite = %SpiderwebHover

func what():
	
	pass

func _ready():
	pass
	# Initially hide the hover sprite

func _input(event):
	pass

# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
#func pre_start(params):
	#var cur_scene: Node = get_tree().current_scene
	#print("Scene loaded: ", cur_scene.name, " (", cur_scene.scene_file_path, ")")
	#if params:
		#for key in params:
			#var val = params[key]
			#printt("", key, val)

## `start()` is called after pre_start and after the graphic transition ends.
#func start():
	#print("forest.gd: start() called")

# Called when the node enters the scene tree for the first time.
#func _ready():
	#%DialogueManager.hide()
	#print(all_dialogues_at_location)
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#var all_dialogues_at_location = {}

#func _on_hotbar_calendar_status(calendar_active):
	##print(calendar_active)
	#if calendar_active == true:
		#%Items.all_dialogues_at_location['Moon'] = ["0Funcionou.","1Yaay!"]
	#else:
		#%Items.all_dialogues_at_location['Moon'] = ["0Não funcionou.","1Aww.", "2Tente usar o calendário da próxima vez!"]
	##print(%Items.all_dialogues_at_location)
#
#func _on_hotbar_alarm_status(alarm_active):
	#pass
	##pass # Replace with function body.
#
#func _on_hotbar_notepad_status(notepad_active):
	#pass # Replace with function body.
#
#func _on_hotbar_sticky_note_status(sticky_note_active):
	#pass # Replace with function body.
#
#func _on_hotbar_to_do_list_status(to_do_list_active):
	#pass # Replace with function body.


func _on_environment_items_test_activity():
	score_gained.emit()
	#print("begjhsdkjg")


func _on_option_1_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("sdjkhghjih")
