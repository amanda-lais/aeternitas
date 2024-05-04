extends Node2D

var contador_pontos = str(randi_range(0,1000000))

func _ready():
	%GameDay.text = "DIA " + str(%DayManager.today)

func _on_forest_score_gained():
	%ScoreCounter.text = str(int(%ScoreCounter.text) + randi_range(0,1000000))
	%DayManager.date_change()

func _on_day_manager_new_day():
	%GameDay.text = "DIA " + str(%DayManager.today)
