extends Area2D

var dial = ["Iniciando preparo...", "...", "..."]
var dialStatus = false
var FracassoOuSucesso = ["Sucesso!", "Fracasso!"]
var woo = 0
var caldeiraoAtivo = false
var pos = 1
var fim = false

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
#			print("Left button was clicked at ", event.position)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	pass # Replace with function body.

func _on_mouse_exited():
	pass # Replace with function body.

#func _on_panel_gui_input(event):
#	if $"../PanelContainer".is_visible_in_tree():
#		$"../PanelContainer".hide()
#	else:
#		$"../PanelContainer".show()

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && fim == false:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and caldeiraoAtivo == false:
			StartCauldron()
			woo+=1
			#_on_panel_gui_input(event)
			print(woo)
		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed and caldeiraoAtivo == true:
			print("whatsapp")
			if pos == (dial.size() -1):
				%PanelContainer.hide()
				dialStatus = false
				ResultsCauldron()
				#$"../PanelContainer/Panel".hide()
			else:
				%RichTextLabel.text = dial[pos]
				pos += 1
		

func StartCauldron():
	%RichTextLabel.text = dial[0]
	$"../PanelContainer".show()
	dialStatus = true
	caldeiraoAtivo = true

func ResultsCauldron():
	if $"../Area2D2".relogio == true and dialStatus == false:
		%RichTextLabel.text = FracassoOuSucesso[0]
		$"../PanelContainer".show()
	elif $"../Area2D2".relogio == false and dialStatus == false:
		%RichTextLabel.text = FracassoOuSucesso[1]
		$"../PanelContainer".show()
	caldeiraoAtivo = false
	fim = true
