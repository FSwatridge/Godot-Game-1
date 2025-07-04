extends ProgressBar

@onready var health_text : Label = $healthtext

func _ready ():
	var char = get_parent()
	max_value = char.max_health
	_update_value(char.cur_health, false,false)
	
	char.OnTakeDamage.connect(_update_value)
	char.OnHeal.connect(_update_value)

func _update_value (health : int, burn: bool, poison: bool):
	value = health
	health_text.text = str(health) + " / " + str(max_value)
