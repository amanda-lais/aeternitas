extends CanvasGroup

var location_items = {}
var outcome

signal show_todolist
signal task_finished(task_id)

func _on_fruit_tree_item_click():
	if %FruitTree.is_unlocked == false:
		await %DialogueManager.dialogue_on_click(["1Uma das tarefas é conseguir um tanto de comida, né?",
		"2Sim...?",
		"1É meio difícil de ver, mas esse pinheiro costuma ter algumas frutas!",
		"1...bem, se você chegar nas frutas antes dos animais por aqui.",
		"2Interessante."
		])
		%FruitTree.is_unlocked = true
	%FruitTree.tree_sound()
	%DialogueOptions.default_option_box()
	if %FruitTree.can_forage == 0:
		if await %FruitTree.click_dialogue("0Deseja coletar as frutas?") == true:
			outcome = %Execution.action()
			if outcome == true:
				await %DialogueManager.run_dialogue("0Circe coletou as frutas!")
				await %FruitTree.forage()
			else:
				%FruitTree.audio_fail()
				await %DialogueManager.run_dialogue("0Circe se distraiu e não coletou as frutas...")
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue("1Talvez depois.")
	else:
		%FruitTree.ftree_already()

func _on_stone_item_click():
	if $Stone.is_unlocked == false:
		await %DialogueManager.dialogue_on_click(["2Há algo especial sobre essa pedra?",
		"1Sim!",
		"1Ela contém alguns [shake]diamantes[/shake] dentro dela!",
		"2[shake]?!?![/shake]",
		"2[shake]Sério?![/shake]",
		"1[wave]Hahahaha!![/wave] Claro que não, Chronos!",
		"2...",
		"2Use essa pedra para minerar."
		])
		$Stone.is_unlocked = true
	%DialogueOptions.default_option_box()
	if await $Stone.click_dialogue("0Deseja minerar?") == true:
		outcome = %Execution.action()
		if outcome == true:
			await %DialogueManager.run_dialogue("0Circe minerou com sucesso!")
			await $Stone.mine_stone()
		else:
			$Stone.audio_fail()
			await %DialogueManager.run_dialogue("0Circe se distraiu e não minerou...")
		%DayManager.date_change()
	else:
		await %DialogueManager.run_dialogue("0Talvez depois.")

func _on_spiderweb_item_click():
	await %DialogueManager.dialogue_on_click(["0(Examina [wave]teia de aranha[/wave])",
	"1Uma [shake]teia de aranha[/shake]!",
	"1Hmm, a aranha que fez isso deve estar por aqui...",
	"2[wave]...[/wave]",
	"0(Circe examina a região)",
	"1Aww... Sem sinal dela...",
	"2(suspira aliviada)",
	"1[wave]?[/wave] O que foi, Chronos?",
	"2Eu [shake]não[/shake] gosto de aranhas...",
	"1Poxa, sério?",
	"1Mas aranhas são tão [shake]fofas[/shake]! E [shake]legais[/shake]!",
	"2...Circe, você sabe que eu sou uma borboleta, certo?",
	'1E [wave]"aranhas comem borboletas", blá blá blá"[/wave], certo?',
	"2Sim! Exatamente!",
	"1Meh. Se eu fosse uma borboleta ainda acharia elas legais.",
	"2[wave]...[/wave]",
	"2[wave]Okay...[/wave]"
])

func _on_crops_item_click():
	if %Crops.is_unlocked == false:
		await %DialogueManager.dialogue_on_click([
			"2Se tivesse me invocado antes, eu teria te feito plantar [shake]tomates[/shake]!",
			"2Aí sim nem precisaria de mim para manejar seu tempo!",
			"2Pfft... heheh...",
			"1[wave]...?[/wave]",
			"1Eu... vou ignorar o que você disse.",
			"1Eu também vou ignorar que logo agora foi o [shake]único momento[/shake] que você riu.",
			"1Eu vou só... plantar os vegetais que preciso plantar..."
		])
		%Crops.is_unlocked = true
	%DialogueOptions.default_option_box()
	if %Crops.crop_current_status == "can plant":
		if await %Crops.click_dialogue("0Deseja plantar?") == true:
			outcome = %Execution.action()
			if outcome == true:
				await %DialogueManager.run_dialogue("0Circe plantou a semente!")
				await %Crops.plant_seed()
				$"Crops/Before Planting".hide()
				$"Crops/After Planting".show()
			else:
				%Crops.audio_fail()
				await %DialogueManager.run_dialogue("0Circe se distraiu...")
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue("2Na verdade... talvez depois.")
	elif %Crops.crop_current_status == "planted":
		if await %Crops.click_dialogue("0Deseja regar?") == true:
			outcome = %Execution.action()
			if outcome == true:
				await %DialogueManager.run_dialogue("0Circe usou um feitiço e regou a planta!")
				await %Crops.water_plant()
			else:
				%Crops.audio_fail()
				await %DialogueManager.run_dialogue("0Circe se distraiu...")
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue("0Talvez depois.")
	elif %Crops.crop_current_status == "watered":
		if await %Crops.click_dialogue("0Deseja colher?") == true:
			outcome = %Execution.action()
			if outcome == true:
				await %DialogueManager.run_dialogue("0Circe colheu os vegetais mágicos!")
				await %Crops.harvest()
				$"Crops/Before Planting".show()
			else:
				%Crops.audio_fail()
				await %DialogueManager.run_dialogue("0Circe se distraiu...")
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue("0Talvez depois.")

func _on_workbench_item_click():
	if $Workbench.is_unlocked == false:
		await %DialogueManager.dialogue_on_click([
			"1Imagina se essa bigorna caísse em cima de você...!",
			"2[shake]????[/shake]",
			"2C-circe, eu já percebi que você acha engraçado me irritar, mas [shake]isso não tem graça[/shake]...",
			"1Hahaha!!",
			"1Não fique com medo, Chronos! Não tem como te achatar mais, você já tem o [wave]máximo achatamento possível![/wave]",
			"2...a culpa de eu ter ido parar no corpo de uma borboleta é de quem?",
			"1Hehehe.",
			"2(suspira) Imagino que você pode consertar o cetro usando essa bigorna...",
			"1Sim! Certinho."
		])
		$Workbench.is_unlocked = true
	if %Inventory.inventory["staff"] > 0:
		$Workbench.workbench_already()
	elif %Inventory.inventory["stone"] < 2:
		$Workbench.workbench_lacking()
	else:
		%DialogueOptions.default_option_box()
		if await $Workbench.click_dialogue($Workbench.workbench_d["prompt"]) == true:
			$Workbench.audio_repair()
			outcome = %Execution.action()
			if outcome == true:
				await %DialogueManager.run_dialogue($Workbench.workbench_d["success"])
				await $Workbench.repair()
			else:
				$Workbench.audio_fail()
				await %DialogueManager.run_dialogue($Workbench.workbench_d["fail"])
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue($Workbench.workbench_d["no"])

func _on_area_2d_input_event(viewport, event, shape_idx):
	pass # Replace with function body.

func _on_close_button_todolist_closed():
	pass # Replace with function body.


func _on_cauldron_item_click():
	if $Cauldron.is_unlocked == false:
		await %DialogueManager.dialogue_on_click([
			"1Aqui eu faço as poções! Contanto que tenha os ingredientes, claro.",
			"2Ooh, tudo certo então. Ótimo.",
			"1Mais ou menos. Eu já peço desculpas caso assuste com alguma explosão.",
			"2Isso... Isso me surpreendeu menos do que deveria.",
			"1[wave]Heh heh heh.[/wave] Está me conhecendo bem!",
			"2Não acho que deveria se orgulhar disso...",
			"2Bem, use um alarme para esse então!"
		])
		$Cauldron.is_unlocked = true
	if %Inventory.inventory["vegetable"] < 2:
		$Cauldron.cauldron_lacking()
	else:
		if await $Cauldron.click_dialogue("0Deseja preparar poções?") == true:
			$Cauldron.audio_boiling()
			if %Alarm.is_active == true:
				await $Cauldron.brew_success()
			else:
				await $Cauldron.brew_fail()
			%DayManager.date_change()
		else:
			await %DialogueManager.run_dialogue("1Talvez depois.")


func _on_tower_item_click():
	await %DialogueManager.dialogue_on_click(["1E é aqui onde eu moro!",
	"2...francamente, eu tenho medo de entrar nesse lugar.",
	"1Por que?",
	"2Eu não vou elaborar...",
	"2(Considerando a bagunça aqui no quintal... Imagino que lá a desorganização irá me matar...)",
	"1Covarde.",
	"2[shake]...!![/shake]",
	"2U-um dia eu entro lá, ok?!",
	"1Heh."
	])
