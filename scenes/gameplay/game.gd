extends Node2D

#to_do_list[task_name] = tasks


var contador_dias = 1
var contador_pontos = str(randi_range(0,1000000))

func _on_forest_score_gained():
	contador_dias += 1
	%GameDay.text = "DIA " + str(contador_dias)
	%ScoreCounter.text = str(int(%ScoreCounter.text) + randi_range(0,1000000))
