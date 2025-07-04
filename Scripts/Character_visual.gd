extends AnimatedSprite2D

#@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	var character = get_parent()
	character.OnTakeDamage.connect(_damage_visual)
	character.OnAttack.connect(_attack_visual)
	#
	#animation_finished.connect(_on_animation_finished)

func _damage_visual (health : int,burn : bool , poison : bool):
	if burn == true:
		modulate = Color.ORANGE
		await get_tree().create_timer(0.1).timeout
		modulate = Color.WHITE
	else:
		animation = "damaged"
		await get_tree().create_timer(0.9).timeout
		play("idle")
	

func _attack_visual (damage : int):
	animation = "attack"
	await get_tree().create_timer(0.9).timeout
	play("idle")
	

	#
