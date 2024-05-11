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

func tdl_show():
	audio_paper()
	%Overlay.show()
	%Tasks.show()
	%DialogueManager.hide()
	await tdl_close()

func tdl_close():
	await %Tasks.todolist_closed
	audio_paper()
	%Tasks.hide()
	%Overlay.hide()

func tdl_or_end():
	%DialogueOptions.set_option_box_text(1, "LISTA DE TAREFAS")
	%DialogueOptions.set_option_box_text(2, "ENCERRAR DIA")
	%DialogueOptions.show_options(2)
	if await %DialogueOptions.option_chosen == 1:
		await tdl_d_default()
		await tdl_show()
	%DialogueOptions.default_option_box()

func tdl_d_default():
	await %DialogueManager.dialogue_on_click([
	"2Talvez tenha algo que possa marcar como feita na lista de tarefas.",
	"1Ah, é verdade!"
	])

func tdl_default():
	await tdl_d_default()
	await tdl_show()

func audio_paper():
	$"Darkworld PaperDocument2".play()
