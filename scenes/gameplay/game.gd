extends Node2D

var contador_pontos = 0
var today = 1

func game_start():
	%GameDay.hide()
	%ScoreCounter.hide()
	$Forest/Blackout.show()
	$BlackoutText.show()

func _ready():
	#game_start()
	$BlackoutText.hide()
	%GameDay.text = "[center]Dia " + str(today) + "[/center]"
	%ScoreCounter.text = "[center]0"  + " pts[/center]"
	$Tasks.hide()
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
	$BlackoutText.text = "[wave][center]No dia seguinte...[/center][/wave]"
	$BlackoutText.show()
	await %Blackout.blackout_clicked
	$BlackoutText.hide()
	%Blackout.hide()

func _on_to_do_list_strategy_click():
	$Tasks.show()
	#%Overlay.show()

func _on_inventory_score_gained(score):
	%ScoreCounter.text = "[center]" + str(int(%ScoreCounter.text) + score) + " pts[/center]"

func _on_tasks_score_gained(score):
	%ScoreCounter.text = "[center]" + str(int(%ScoreCounter.text) + score) + " pts[/center]"

func _on_environment_strategies_score_gained(score):
	%ScoreCounter.text = "[center]" + str(int(%ScoreCounter.text) + score) + " pts[/center]"
