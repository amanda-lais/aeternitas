extends Node

signal new_day
signal full_moon

var game_days = {}
var today
var today_info

var alarm_clicked_today
var to_do_list_opened_today
var calendar_opened_today
var calendar_upcoming_checked_today

# Called when the node enters the scene tree for the first time.
func _ready():
	today = 1

func day_reset():
	%Alarm.is_active = false
	%ToDoList.is_active = false
	%Calendar.is_active = false
	calendar_upcoming_checked_today = false
	if %FruitTree.can_forage == 1:
		%FruitTree.can_forage += 1
	elif %FruitTree.can_forage == 2:
		%FruitTree.can_forage = 0
	if %Crops.crop_current_status == "watered":
		$"../../Forest/EnvironmentItems/Crops/Pumpkin".show()

func date_change():
	if today != 10:
		%Blackout.show()
		$Night.play()
		if today == 5:
			full_moon.emit()
			if %Alarm.is_active == true:
				%Alarm.crow_audio()
				await %DialogueManager.dialogue_on_click(["1[shake]!![/shake]",
				"1A [shake]lua cheia[/shake]!!",
				"1Vou recarregar meu cetro!",
				"0...",
				"0[wave]...[/wave]",
				"0[wave].....[/wave]",
				"1Prontinho, cetro recarregado!"])
		await %Blackout.blackout_clicked
		today += 1
		day_reset()
		new_day.emit()
		$Night.stop()
	elif today == 10:
		%Blackout.show()
		$"../Main Game".stop()
		%BlackoutText.text = "[center][wave]Pontuação: " + str($"../..".game_score) + " pontos.[/wave][/center]"
		%BlackoutText.show()
		await %Blackout.blackout_clicked
		if $"../..".game_score > 800:
			%BlackoutText.hide()
			$"../Win".play()
			$"../Blackout/CirceEnding".show()
			$"../Blackout/BlackoutTextLeft".show()
			$"../Blackout/BlackoutTextLeft".text = "[wave]E assim...[/wave]"
			await %Blackout.blackout_clicked
			$"../Blackout/BlackoutTextLeft".text = "[wave]Circe fez sua jornada...[/wave]"
			await %Blackout.blackout_clicked
			$"../Blackout/BlackoutTextLeft".text = "[wave]E conseguiu impedir o fim do mundo![/wave]"
			await %Blackout.blackout_clicked
			$"../Blackout/BlackoutTextLeft".hide()
			$"../Blackout/Thanks".show()
		else:
			$"Game Over Music".play()
			%BlackoutText.text = "[center][shake]E o mundo acabou-se![/shake][/center]"
			await %Blackout.blackout_clicked
			%BlackoutText.text = "[center]...é o que eu diria, porém algo que não contei pra Circe é que...[/center]"
			await %Blackout.blackout_clicked
			%BlackoutText.text = "[center]Felizmente, como uma entidade de tempo, eu sou capaz de voltar ao passado...[/center]"
			await %Blackout.blackout_clicked
			%BlackoutText.text = "[center][wave]Bem, hora de tentar de novo![/wave][/center]"
			$"../Arcane Wind Chime Gust".play()
