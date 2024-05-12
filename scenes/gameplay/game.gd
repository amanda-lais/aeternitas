extends Node2D

var contador_pontos = 0
var today = 1
var start_sequence = false
signal start_seq_click
var game_score = 0

func game_start():
	start_sequence = true
	%GameDay.hide()
	%ScoreCounter.hide()
	%Blackout.show()
	await _on_blackout_blackout_clicked

func _ready():
	await game_start()
	#%BlackoutText.hide()
	%GameDay.text = "[center]Dia " + str(today) + "[/center]"
	%ScoreCounter.text = "[center]0"  + " pts[/center]"
	%Tasks.hide()
	$Caw.hide()
	%Mess.is_active = true
	$Forest/EnvironmentItems/Crops/Pumpkin.hide()
	$"Forest/EnvironmentItems/Crops/Before Planting".show()
	$"Forest/EnvironmentItems/Crops/After Planting".hide()
	$Forest/EnvironmentStrategies/Alarm/Crow.play()
	$Forest/EnvironmentItems/FruitTree/Tree.play()
#func _on_forest_score_gained():
#	%ScoreCounter.text = str(int(%ScoreCounter.text)) #+ randi_range(0,1000000))

func _on_day_manager_new_day():
	today +=1
	%GameDay.text = "[center]Dia " + str(today) + "[/center]"
	%BlackoutText.text = "[wave][center]No dia seguinte...[/center][/wave]"
	%BlackoutText.show()
	await %Blackout.blackout_clicked
	%BlackoutText.hide()
	%Blackout.hide()

func _on_to_do_list_strategy_click():
	%Tasks.show()
	#%Overlay.show()

func _on_inventory_score_gained(score):
	game_score += score
	%ScoreCounter.text = "[center]" + str(int(%ScoreCounter.text) + score) + " pts[/center]"

func _on_tasks_score_gained(score):
	game_score += score
	%ScoreCounter.text = "[center]" + str(int(%ScoreCounter.text) + score) + " pts[/center]"

func _on_environment_strategies_score_gained(score):
	game_score += score
	%ScoreCounter.text = "[center]" + str(int(%ScoreCounter.text) + score) + " pts[/center]"

var color = "FF7100"

var start_dialogue_center = ["[center]Entre os eventos corriqueiros mais comuns, um dos favoritos de todo mundo é com certeza [wave][color=" + color + "]O FIM DO MUNDO[/color][/wave].[/center]",
	"[center]Desta vez, ele acontecerá, caso não impedido, devido [color=" + color + "][shake]À CALAMIDADE[/shake][/color].[/center]",
	"[center][shake]Calamidades[/shake] consistem em eventos catastróficos que só podem ser impedidos por [shake]usuários de magia[/shake].[/center]",
	"[center][shake]A única bruxa capaz de impedir A Calamidade atual é [color=" + color + "]Circe[/color][/shake].[/center]",
	""
	]

var start_dialogue_right = [
	"[wave]Circe[/wave] é extremamente poderosa, e para ela, a tarefa de salvar o mundo é muito fácil!",
	"Porém, até ela precisa fazer alguns preparos para a jornada à sua frente...",
	"E essa é sua grande dificuldade: [shake]manejar o próprio tempo[/shake].",
	"Para Circe, então, a dificuldade não seria salvar o mundo...",
	"E sim salvar o mundo [shake][color="+ color + "]a tempo."
	]

func _on_blackout_blackout_clicked():
	if start_sequence == true and start_dialogue_center.is_empty() == true and start_dialogue_right.is_empty() == true:
		initial_dialogue()
	if start_sequence == true and start_dialogue_center.is_empty() == false:
		$Gameplay/Blackout/BlackoutTitle.hide()
		%BlackoutText.show()
		%BlackoutText.text = start_dialogue_center[0]
		start_dialogue_center.pop_front()
		if start_dialogue_center.is_empty() == true:
			$Gameplay/Blackout/CirceArt.show()
	elif start_sequence == true and start_dialogue_center.is_empty() == true and start_dialogue_right.is_empty() == false:
		%BlackoutTextRight.show()
		%BlackoutTextRight.text = start_dialogue_right[0]
		start_dialogue_right.pop_front()

func initial_dialogue():
	$Gameplay/Blackout/BlackoutTitle.hide()
	%BlackoutText.hide()
	$Gameplay/Blackout/CirceArt.hide()
	%BlackoutTextRight.hide()
	%Blackout.hide()
	%GameDay.show()
	%ScoreCounter.show()
	await %DialogueManager.dialogue_on_click([
	"0Hrhmm...",
	"0Quem me invocou...?",
	"1Ohh, o feitiço de invocação funcionou perfeitamente!",
	"0Hmm...",
	"0Ah, você é Circe? A bruxa que irá impedir A Calamidade?",
	"1[wave]![/wave]",
	"1Sim, eu mesma!",
	"0[wave]Hmmm...[/wave]",
	"0Deduzo então que me invocou para auxiliar na jornada...",
	"0...Isso é bom, considerando que me preocupa que, uh...",
	"0Apesar de você ter sido informada faz 3 meses, faltam 10 dias e as preparações deixam a desejar...",
	"0...Esse corpo de borboleta é bem limitado, porém... Não devo conseguir fazer muita coisa...",
	"0E minha memória está... um pouco falha...",
	"1[wave]?[/wave]",
	"1Ah, eu invoquei uma entidade especial?",
	"1Eu só estava testando transformar o laço do meu chapéu em borboleta, e então tentar invocar algo na borboleta.",
	"1Apenas para saber se funcionaria.",
	"0....",
	"0[wave]....[/wave]",
	"2Haa... Eu sou [wave]Chronos[/wave]. Uma entidade com poderes de tempo.",
	"2Você não pediu, mas eu vou te auxiliar.",
	"1Hã... N-não precisa! Eu vou começar a me preparar hoje por conta própria!",
	"2Você está falando isso há 3 meses.",
	"1........[shake]Como você descobriu?[/shake]",
	"2Ah... Eu tinha blefado...",
	"2C-certo...",
	"2Bem, para começar... Como só temos 10 dias, só devo conseguir te fazer usar duas estratégias: uma lista de tarefas e um calendário."
	])
	$CalTdl/Timer.start(2)
	$CalTdl.show()
	$Gameplay/DialogueManager/Sprite2D.hide()
	$Gameplay/DialogueManager/Sprite2D2.hide()
	%Overlay.show()

func _on_timer_timeout():
	$CalTdl.hide()
	$Gameplay/DialogueManager/Sprite2D.show()
	$Gameplay/DialogueManager/Sprite2D2.show()
	await %DialogueManager.dialogue_on_click(["2Eu também queria te fazer usar alarmes, mas com meu poder atual não consigo...",
	"1Ah, para esse eu consigo dar um jeito!",
	"1Oh? Me mostre depois.",
	"2Bem, no calendário coloquei o mais importante, na lista de tarefas idem.",
	"2Se conseguir tudo ou quase tudo da lista de tarefas... Deve conseguir salvar o mundo tranquilamente.",
	"2Ah, e eu irei pontuando sua performance. Alguns pontos não terão a ver com A Calamidade e são só sobre seu uso das estratégias, mesmo.",
	"Creio que a partir de 800 pontos as preparações são suficientes.",
	"1Okay...",
	"2De qualquer maneira, use as estratégias sempre que conseguir!",
	"2Elas devem aumentar as chances de cada ação sua dar certo, dependendo devem aumentar MUITO.",
	"1Hm... entendido."
	])
	start_sequence = false
