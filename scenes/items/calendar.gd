extends "res://scenes/items/strategy.gd"

var full_moon_day = 5
var first_dialogue = "0Isso é um Calendário!"

var other_calendar_events = {}

var dialogue_default = [
	"1Uuh... tinha algo...? Err, amanhã? Ou já foi... Não me lembro...",
	"2Minha sugestão sobre o que checar no calendário é..."
	]

var full_moon_today = [
	"1...Hoje à noite haverá a lua cheia.",
	"1Hm... Eu vou precisar da lua para recarregar meu cetro mágico.",
	"2Oh, isso é importante!",
	"2Seria bom usar um alarme, talvez. Para evitar esquecer na hora.",
	"1E agora de dia posso fazer outra coisa normalmente, certo?",
	"2Isso.",
	"2...só não esqueça do alarme.",
	"1Eu nunca esqueceria algo assim, Chronos!",
	"2...",
	"1...tá, você tem um ponto."
	]

var full_moon_tomorrow = [
	"1...Amanhã à noite acontecerá a lua cheia.",
	"1Hm... Eu vou precisar da lua para recarregar meu cetro mágico.",
	"2Oh, isso é importante!",
	"2Seria bom usar um alarme, talvez. Para evitar esquecer na hora.",
	"1E amanhã durante o dia posso fazer outra coisa normalmente, certo?",
	"2Isso.",
	"2...só não esqueça do alarme.",
	"1Eu sei, eu sei..."
	]

var dialogue_boxes = {
	1: "HOJE",
	2: "AMANHÃ",
	3: "EM GERAL"
}

#var today
#var tomorrow
#var coming_up
var calendar_checked_today
#var previously_checked_today
var event_today
var calendar_events = {
	1: "",
	2: "",
	3: "",
	4: "",
	5: "full_moon",
	6: "",
	7: "",
	8: "last_day"
}

func check_today():
	var dialogue = []
	var today = %DayManager.today
	if calendar_events[%DayManager.today] == "full_moon":
		dialogue = full_moon_today
	for i in other_calendar_events:
		if other_calendar_events[i] == today:
			if i == "forage_again":
				dialogue.append("1...Ah, espera, hoje eu já posso coletar mais frutas!")
			elif i == "water_crop":
				dialogue.append("1Hoje eu já posso regar as plantas.")
				dialogue.append("1...e 1 dia depois de regar, eu posso colher.")
				dialogue.append("1Então se eu regar hoje, amanhã posso ter os vegetais mágicos!")
			elif i == "harvest_crop":
				dialogue.append("1Finalmente eu posso colher meus vegetais mágicos!")
				dialogue.append("2Ooh! Boa, Circe!")
	if dialogue.is_empty():
		dialogue.append("1Hm... Não há nada hoje.")
	return dialogue

func check_tomorrow():
	var dialogue = []
	var tomorrow = %DayManager.today+1
	if calendar_events[tomorrow] == "full_moon":
		dialogue = full_moon_tomorrow
	for i in other_calendar_events:
		if other_calendar_events[i] == tomorrow:
			if i == "forage_again":
				dialogue.append("1...Ah, espera! Amanhã eu já posso coletar mais frutas!")
			elif i == "water_crop":
				dialogue.append("1Amanhã eu posso regar as plantas.")
				dialogue.append("1...e 1 dia depois de regar, eu posso colher.")
				dialogue.append("1Então se eu regar amanhã, depois de amanhã posso ter os vegetais mágicos!")
			elif i == "harvest_crop":
				dialogue.append("1Amanhã posso pegar meus vegetais mágicos!")
				dialogue.append("2Finalmente!")
	if dialogue.is_empty():
		dialogue.append("1Hm... Não há nada marcado para amanhã.")
	return dialogue

func check_overall():
	var dialogue = ["1Vamos ver..."]
	var phrase = ""
	for i in calendar_events:
		if calendar_events[i] != "" and i>=%DayManager.today:
			phrase += "1No dia " + str(i) + ", "
			if calendar_events[i] == "full_moon":
				dialogue.append(phrase + "haverá a lua cheia à noite.")
				dialogue.append("1Hm... Eu vou precisar da lua para recarregar meu cetro mágico.")
				dialogue.append("2Oh, isso é importante!")
				dialogue.append("2Seria bom usar um alarme, talvez. Para evitar esquecer no dia.")
				dialogue.append("1Haha... Seria mesmo...")
	for i in other_calendar_events:
		if other_calendar_events[i] >= %DayManager.today:
			if i == "forage_again":
				dialogue.append("1...Ah, no dia " +
				str(other_calendar_events[i]) +
				" já posso coletar mais frutas!")
			elif i == "water_crop":
				dialogue.append("1No dia " +
				str(other_calendar_events[i]) +
				" posso regar as plantas.")
				dialogue.append("1...então um dia depois de regar eu já vou poder colher!")
			elif i == "harvest_crop":
				dialogue.append("1No dia " +
				str(other_calendar_events[i]) +
				" poderei finalmente colher os vegetais mágicos!!")
	return dialogue

#harvest_cropwater_crop

func add_to_calendar(event, day):
	other_calendar_events[event] = day

func check_day_x(day_x):
	#day_x[rng] -= 0.07
	pass

func chronos_reminders_when_unrelated():
	if calendar_checked_today == true && event_today == true:
		pass

