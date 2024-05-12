extends Sprite2D

signal strategy_click
#signal strategy_info (strategy_name, strategy_is_active)

var strategy_name
var strategy_info
var is_unlocked
var is_active

func update_info():
	strategy_info = {"item_name": strategy_name, "is_unlocked": is_unlocked, "is_active": is_active}
	%EnvironmentStrategies.location_strategies[strategy_name] = strategy_info

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hover.hide()
	strategy_info = {}
	strategy_name = get_name()
	is_unlocked = false
	is_active = false
	update_info()

func unlock_strategy():
	is_unlocked = true
	update_info()

func activate_strategy():
	is_active = true
	update_info()

func set_alarm():
	print(%Alarm.is_active)
	crow_audio()
	%Alarm.is_active = true
	print(%Alarm.is_active)

func crow_audio():
	$"Crow Sound".play()
	%Caw.show()
	$Timer.start(0.5)

func clean_up():
	%DialogueManager.run_dialogue("1Tudo limpo agora!")
	%Mess.hide()
	%Mess.is_active = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			strategy_click.emit()

func _on_area_2d_mouse_entered():
	$Hover.show()

func _on_area_2d_mouse_exited():
	$Hover.hide()
