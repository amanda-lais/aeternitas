extends Control

var to_do_list
var to_do_list_exp
var to_do_list_checked_today
var to_do_list_level
#var checklist_checks_pending

# Called when the node enters the scene tree for the first time.
func _ready():
	$RepairStaff.dialogue_task_name = "Consertar cetro mágico"
	$ChargeStaff.dialogue_task_name = "Recarregar cetro mágico"
	$GetFood.dialogue_task_name = "Acumular comida o suficiente"
	$StockPotions.dialogue_task_name = "Preparar poções o suficiente"
	$RepairStaff/AcquireRock.dialogue_task_name = "Conseguir 2 pedaços de pedra (material para conserto)"
	$RepairStaff/RepairStaff.dialogue_task_name = "Fazer o reparo"
	$ChargeStaff/RepairStaff.dialogue_task_name = "Consertar cetro mágico"
	$ChargeStaff/MoonExposure.dialogue_task_name = "Usar lua cheia para recarregar o cetro mágico"
	$StockPotions/PlantSeed.dialogue_task_name = "Plantar semente"
	$StockPotions/WaterCrop.dialogue_task_name = "Regar plantas"
	$StockPotions/HarvestCrop.dialogue_task_name = "Colher os vegetais mágicos"
	$StockPotions/BrewPotion.dialogue_task_name = "Cozinhar poções o suficiente"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
