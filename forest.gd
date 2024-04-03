extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	%DialogueManager.hide()
	#print(all_dialogues_at_location)
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#var all_dialogues_at_location = {}

func _on_hotbar_calendar_status(calendar_active):
	#print(calendar_active)
	if calendar_active == true:
		%Items.all_dialogues_at_location['Moon'] = ["0Funcionou.","1Yaay!"]
	else:
		%Items.all_dialogues_at_location['Moon'] = ["0Não funcionou.","1Aww.", "2Tente usar o calendário da próxima vez!"]
	#print(%Items.all_dialogues_at_location)

func _on_hotbar_alarm_status(alarm_active):
	pass
	#pass # Replace with function body.

func _on_hotbar_notepad_status(notepad_active):
	pass # Replace with function body.

func _on_hotbar_sticky_note_status(sticky_note_active):
	pass # Replace with function body.

func _on_hotbar_to_do_list_status(to_do_list_active):
	pass # Replace with function body.
