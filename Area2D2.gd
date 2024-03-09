extends Area2D

var relogio = false
var DialogueActive = false
var Dial = ["Relógio ativado!", "...", "...."]

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and relogio==false:
			print("Left button was clicked at ", event.position)
			_on_panel_gui_input(event)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_panel_gui_input(event):
	%RichTextLabel.text = Dial[0]
	$"../PanelContainer".show()
	relogio = true
	DialogueActive = true
	#if event.button_index == MOUSE_BUTTON_LEFT and DialogueActive:
	#		$"../PanelContainer".hide()
