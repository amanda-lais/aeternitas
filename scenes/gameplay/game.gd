extends Node2D

var contador_pontos = 0 #str(randi_range(0,1000000))
var today = 1

func _ready():
	%GameDay.text = "Dia " + str(today)
	%ScoreCounter.text = "0"  + " pts"
	$Tasks.hide()
	$Forest/EnvironmentItems/Crops/Pumpkin.hide()
	$Forest/EnvironmentItems/Crops/Land.show()
	$Forest/EnvironmentStrategies/Alarm/Crow.play()
	$Forest/EnvironmentItems/FruitTree/Tree.play()
#func _on_forest_score_gained():
#	%ScoreCounter.text = str(int(%ScoreCounter.text)) #+ randi_range(0,1000000))

func _on_day_manager_new_day():
	$Blackout.show()
	await $Blackout.blackout_clicked
	today +=1
	%GameDay.text = "Dia " + str(today)
	await $Blackout.blackout_clicked
	$Blackout.hide()

func _on_to_do_list_strategy_click():
	$Tasks.show()
	#%Overlay.show()

func _on_inventory_score_gained(score):
	%ScoreCounter.text = str(int(%ScoreCounter.text) + score) + " pts"

func _on_tasks_score_gained(score):
	%ScoreCounter.text = str(int(%ScoreCounter.text) + score) + " pts"

func _on_environment_strategies_score_gained(score):
	%ScoreCounter.text = str(int(%ScoreCounter.text) + score) + " pts"
