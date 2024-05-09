extends CanvasGroup

var choice
var option_box_amount = 2
var location_strategies = {}

signal score_gained(score)

func dialogue_on_click(dialogue):
	%DialogueManager.dialogue_list = dialogue
	%DialogueManager.start_dialogue()
	await %DialogueManager.dialogue_finished

func run_dialogue(dialogue):
	%DialogueManager.dialogue_list = [dialogue]
	%DialogueManager.start_dialogue()
	await %DialogueManager.dialogue_finished

func generic_branch(dialogue, box_amount, box1, box2, box3=""):
	%DialogueOptions.set_option_box_text(1, box1)
	%DialogueOptions.set_option_box_text(2, box2)
	%DialogueOptions.set_option_box_text(3, box3)
	await dialogue_on_click(dialogue)
	%DialogueOptions.show_options(box_amount)
	var option_number = await %DialogueOptions.option_chosen
	return option_number

# Called when the node enters the scene tree for the first time.
func _ready():
	%DialogueOptions.set_option_box_text(1, "SIM")
	%DialogueOptions.set_option_box_text(2, "NÃO")
	%DialogueOptions.set_option_box_text(3, "ESPERA")

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
		run_dialogue(%Calendar.first_dialogue)
		%Calendar.unlock_strategy()
	elif %EnvironmentStrategies.location_strategies[node_name].is_active == false:
		%Calendar.activate_strategy()
	choice = await generic_branch(
		%Calendar.dialogue_default,
		3,
		%Calendar.dialogue_boxes[1],
		%Calendar.dialogue_boxes[2],
		%Calendar.dialogue_boxes[3])
	if choice == 1:
		run_dialogue("2Verifique hoje!")
		dialogue_on_click(%Calendar.check_today())
	elif choice == 2:
		run_dialogue("2Verifique amanhã!")
		dialogue_on_click(%Calendar.check_tomorrow())
	elif choice == 3:
		run_dialogue("2Dê uma olhada no calendário em geral!")
		dialogue_on_click(%Calendar.check_overall())

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
			score_gained.emit(10)
	else:
		run_dialogue("0Mais nada para fazer aqui...")

func _on_mess_strategy_click():
	var dialogue = "0Você gostaria de limpar a bagunça?"
	run_dialogue(dialogue)
	await %DialogueManager.dialogue_finished
	%DialogueOptions.show_options(3)
	var option_number = await %DialogueOptions.option_chosen
	if option_number == 1:
		dialogue = "0Tudo limpo agora!"
		score_gained.emit(40)
		%Mess.hide()
	elif option_number == 2:
		dialogue = "1Depois..."
	elif option_number == 3:
		dialogue = "0Oopsie?"
	run_dialogue(dialogue)

func _on_dialogue_manager_dialogue_finished(option_box_amount):
	pass

func _on_dialogue_options_option_chosen(option_number):
	pass
