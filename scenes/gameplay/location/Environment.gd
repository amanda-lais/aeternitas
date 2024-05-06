extends CanvasGroup

var is_environment_clickable

# Called when the node enters the scene tree for the first time.
func _ready():
	is_environment_clickable = true

func env_set_as_clickable():
	is_environment_clickable = false

func env_set_as_unclickable():
	is_environment_clickable = true
