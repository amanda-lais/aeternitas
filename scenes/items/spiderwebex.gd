extends "res://scenes/items/item.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_click():
	%DialogueManager.dialogue_list = %EnvironmentItems.all_dialogues_at_location[get_name()]
	%DialogueManager.start_dialogue()
