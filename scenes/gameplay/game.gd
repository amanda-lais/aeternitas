extends Node2D

var contador_pontos = str(randi_range(0,1000000))
var today = 1

func _ready():
	%GameDay.text = "DIA " + str(today)
	$Tasks.hide()

func _on_forest_score_gained():
	%ScoreCounter.text = str(int(%ScoreCounter.text) + randi_range(0,1000000))

func _on_day_manager_new_day():
	$Blackout.show()
	await $Blackout.blackout_clicked
	today +=1
	%GameDay.text = "DIA " + str(today)
	await $Blackout.blackout_clicked
	$Blackout.hide()

func _on_to_do_list_strategy_click():
	$Tasks.show()
