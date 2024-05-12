extends CanvasGroup

var choice
var option_box_amount = 2
var location_strategies = {}

signal score_gained(score)

func maybe_use_strategy():
	await %DialogueManager.run_dialogue("2Hmmm...")
	%DialogueOptions.set_option_box_text(1, "USAR ESTRATÉGIA")
	%DialogueOptions.set_option_box_text(2, "ENCERRAR DIA")
	%DialogueOptions.show_options(2)
	var option = await %DialogueOptions.option_chosen
	%DialogueOptions.default_option_box()
	return option

func choose_strategy_3(cal=true, tdl=true, alarm=false, action = "", add = "", date = 0):
	choice = await maybe_use_strategy()
	if choice == 1:
		if cal == true and tdl == true:
			await dialogue_on_click([
				"2O que acha de usarmos uma estratégia agora, Circe?",
				"1Hmm... Pode ser. Vamos usar... uh, qual mesmo..."
				])
			%DialogueOptions.set_option_box_text(1, "CALENDÁRIO")
			%DialogueOptions.set_option_box_text(2, "LISTA DE TAREFAS")
			%DialogueOptions.set_option_box_text(3, "ENCERRAR DIA")
			%DialogueOptions.show_options(3)
			choice = await %DialogueOptions.option_chosen
			%DialogueOptions.default_option_box()
			if choice == 1:
				await %Calendar.cal_default(action, add, date)
				await %ToDoList.tdl_or_end()
			elif choice == 2:
				await %ToDoList.tdl_default()
				await %Calendar.cal_or_end(action, add, date)
		elif cal == false and tdl == true:
			await %DialogueManager.run_dialogue("2([wave]Hmmmmm...[/wave])")
			await %ToDoList.tdl_or_end()
		elif cal == true and tdl == false:
			await %DialogueManager.run_dialogue("2([wave]Hmmmmm...[/wave])")
			await %Calendar.cal_or_end(action, add, date)

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

func activate_strategy(strategy_name, option_box_amount = 2):
	var dialogue = "0Deseja utilizar " + strategy_name.capitalize() + "?"
	run_dialogue(dialogue)
	await %DialogueManager.dialogue_finished
	%DialogueOptions.show_options(option_box_amount)
	var option_number = await %DialogueOptions.option_chosen
	if option_number == 1:
		dialogue = "0" + strategy_name.capitalize() + " ativado!"
	elif option_number == 2:
		$"../DialogueOptions/Fantasy_UI cancel".play()
		dialogue = "0Okay."
	elif option_number == 3:
		dialogue = "0Oopsie?"
	run_dialogue(dialogue)
	await %DialogueManager.dialogue_finished
	return option_number

func _on_to_do_list_strategy_click():
	var strategy_name = "lista de tarefas"
	var node_name = "ToDoList"
	%ToDoList.activate_strategy()
	if %EnvironmentStrategies.location_strategies[node_name].is_unlocked == false:
		%ToDoList.unlock_strategy()

func _on_calendar_strategy_click():
	var strategy_name = "calendário"
	var node_name = "Calendar"
	%Calendar.activate_strategy()
	if %EnvironmentStrategies.location_strategies[node_name].is_unlocked == false:
		run_dialogue(%Calendar.first_dialogue)
		%Calendar.unlock_strategy()
	else:
		run_dialogue(%Calendar.first_dialogue)
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
	%DialogueOptions.default_option_box()

func _on_alarm_strategy_click():
	%Alarm.crow_audio()
	var strategy_name = "alarme"
	var node_name = "Alarm"
	if %EnvironmentStrategies.location_strategies[node_name].is_unlocked == false:
		var dialogue = [
			"1Hmm.. Você citou usar alarmes, certo Chronos?",
			"1Bem, isso é um alarme!",
			"2[wave]...[/wave]",
			"2[shake]???[/shake]",
			"2Isso é um corvo...",
			"1Essas coisas não são mutuamente exclusivas!",
			"1E não chame meu Noir de [wave]'um corvo'[/wave]!",
			"2...você falou que ele é um alarme, como chamar de corvo seria pior?",
			"1[shake]Eu[/shake] posso. [shake]Você[/shake] não.",
			"2[wave]...[/wave]",
			"2[wave]...mudando de assunto...[/wave]",
			"2...ele consegue funcionar como um alarme mesmo?",
			"1Sim, consegue. Eu treinei muito bem meu Noir.",
			"2Hmm..."
		]
		dialogue_on_click(dialogue)
		%Alarm.unlock_strategy()
	elif %EnvironmentStrategies.location_strategies[node_name].is_active == false:
		choice = await activate_strategy(strategy_name)
		if choice == 1:
			%Alarm.set_alarm()
			score_gained.emit(10)
	else:
		run_dialogue("0Mais nada para fazer aqui...")

func _on_mess_strategy_click():
	var dialogue = "0Você gostaria de limpar a bagunça?"
	run_dialogue(dialogue)
	await %DialogueManager.dialogue_finished
	%DialogueOptions.show_options(2)
	var option_number = await %DialogueOptions.option_chosen
	if option_number == 1:
		score_gained.emit(40)
		await %Mess.clean_up()
	elif option_number == 2:
		await later()
	elif option_number == 3:
		dialogue = "0?"

func later():
	%DialogueManager.run_dialogue("1Uh... eu faço isso depois.")
	%DialogueOptions.cancel_audio()

func _on_dialogue_manager_dialogue_finished(option_box_amount):
	pass

func _on_dialogue_options_option_chosen(option_number):
	pass
