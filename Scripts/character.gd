class_name Character
extends Node2D

signal OnTakeDamage (health : int)
signal OnHeal (health : int)
signal OnAttack (damage : int)

@export var is_player : bool
var rng = RandomNumberGenerator.new()

@export var cur_health : int
@export var max_health : int

@export var speed : int
@export var facing_left : bool
@export var display_texture : Texture2D


@export var combat_actions : Array[CombatAction]

var target_scale : float = 1.0

@onready var audio : AudioStreamPlayer = $AudioStreamPlayer
var take_damage_sfx : AudioStream = preload("res://Audio/take_damage.wav")
var heal_sfx : AudioStream = preload("res://Audio/heal.wav")

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

#func _ready():
#	sprite.flip_h = facing_left
#	sprite.texture = display_texture

func begin_turn ():
	target_scale = 1.1

func end_turn ():
	target_scale = 0.9

func _process (delta):
	scale.x = lerp(scale.x, target_scale, delta * 10)
	scale.y = lerp(scale.y, target_scale, delta * 10)

func take_damage (amount : int , burn : bool , poison : bool):
	cur_health -= amount
	OnTakeDamage.emit(cur_health)
	_play_audio(take_damage_sfx)

func take_dot_damage (amount : int , max_tick : int ,  burn : bool , poison : bool):
	rng.randomize()
	var ticks = randi_range(0,max_tick)
	for i in range(0,ticks):
		take_damage(2,burn,poison)

func heal (amount : int):
	cur_health += amount
	cur_health = clamp(cur_health, 0, max_health)
	OnHeal.emit(cur_health)
	_play_audio(heal_sfx)

func cast_combat_action (action : CombatAction, opponent : Character):
	if action == null:
		return
	
	if action.melee_damage > 0:
		opponent.take_damage(action.melee_damage,false,false)
		OnAttack.emit(action.melee_damage)
	
	if action.heal_amount > 0:
		heal(action.heal_amount)

func _play_audio (stream : AudioStream):
	audio.stream = stream
	audio.play()
