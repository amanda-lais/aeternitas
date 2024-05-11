extends "res://scenes/items/strategy.gd"

var exp = 0
var lvl = 1

signal level_up

func _on_environment_items_exp_gained(exp_points):
	exp += exp_points
	print(exp)
	if exp_points > 50 and lvl == 1:
		lvl = 2
		level_up.emit()

#### DIALOGUES ####

var default_todolist_dialogue = [
	"2Talvez tenha algo que possa marcar como feita na lista de tarefas.",
	"1Ah, é verdade!"
	]

func tdl_or_end():
	%DialogueOptions.set_option_box_text(1, "LISTA DE TAREFAS")
	%DialogueOptions.set_option_box_text(2, "ENCERRAR DIA")
	%DialogueOptions.show_options(2)
	return await %DialogueOptions.option_chosen
