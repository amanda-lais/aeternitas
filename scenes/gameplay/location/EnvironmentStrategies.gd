extends CanvasGroup

var choice
var option_box_amount = 2
var location_strategies = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	%DialogueOptions.set_option_box_text(1, "YES")
	%DialogueOptions.set_option_box_text(2, "NO")
	%DialogueOptions.set_option_box_text(3, "WAIT")

func run_dialogue(dialogue):
	%DialogueManager.dialogue_list = [dialogue]
	%DialogueManager.start_dialogue()

func activate_strategy(strategy_name, option_box_amount = 3):
	var dialogue = "0Deseja utilizar " + strategy_name.capitalize() + "?"
	run_dialogue(dialogue)
	await %DialogueManager.dialogue_finished
	%DialogueOptions.show_options(option_box_amount)
	var option_number = await %DialogueOptions.option_chosen
	if option_number == 1:
		dialogue = "0" + strategy_name.capitalize() + " ativado!"
	elif option_number == 2:
		dialogue = "0Okay."
	elif option_number == 3:
		dialogue = "0Oopsie?"
	run_dialogue(dialogue)
	await %DialogueManager.dialogue_finished
	return option_number

func _on_to_do_list_strategy_click():
	var strategy_name = "lista de tarefas"
	var node_name = "ToDoList"
	if %EnvironmentStrategies.location_strategies[node_name].is_unlocked == false:
		%ToDoList.unlock_strategy()
	elif %EnvironmentStrategies.location_strategies[node_name].is_active == false:
		%ToDoList.activate_strategy()

func _on_calendar_strategy_click():
	var strategy_name = "calendário"
	var node_name = "Calendar"
	if %EnvironmentStrategies.location_strategies[node_name].is_unlocked == false:
		run_dialogue("0Isso é um Calendário!")
		%Calendar.unlock_strategy()
	elif %EnvironmentStrategies.location_strategies[node_name].is_active == false:
		choice = await activate_strategy(strategy_name)
		if choice == 1:
			%Calendar.activate_strategy()
	else:
		run_dialogue("0Mais nada para fazer aqui...")

func _on_alarm_strategy_click():
	var strategy_name = "alarme"
	var node_name = "Alarm"
	if %EnvironmentStrategies.location_strategies[node_name].is_unlocked == false:
		run_dialogue("0Isso é um Alarme!")
		%Alarm.unlock_strategy()
	elif %EnvironmentStrategies.location_strategies[node_name].is_active == false:
		choice = await activate_strategy(strategy_name)
		if choice == 1:
			%Alarm.activate_strategy()
	else:
		run_dialogue("0Mais nada para fazer aqui...")

func _on_mess_strategy_click():
	var dialogue = "0Do you want to clean up the mess?"
	run_dialogue(dialogue)
	await %DialogueManager.dialogue_finished
	%DialogueOptions.show_options(3)
	var option_number = await %DialogueOptions.option_chosen
	if option_number == 1:
		dialogue = "0Cleaned up!"
	elif option_number == 2:
		dialogue = "0Alright."
	elif option_number == 3:
		dialogue = "0Oopsie?"
	run_dialogue(dialogue)

func _on_dialogue_manager_dialogue_finished(option_box_amount):
	pass

func _on_dialogue_options_option_chosen(option_number):
	pass
