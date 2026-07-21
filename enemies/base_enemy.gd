class_name BaseEnemy
extends CharacterBody2D
var enemy_speed = 30
var target = null
@export var enemy_data:EnemyData
@onready var timer = $Timer
var life:int
var damage:int
var enemy_name:String
@onready var sprite: Sprite2D = $Sprite2D
func _ready() -> void:
	if enemy_data:
		enemy_name=enemy_data.enemy_name
		life=enemy_data.life
		damage=enemy_data.damage
		print("Nome do inimigo carregado: ", enemy_name)
		print("Textura no Resource: ", enemy_data.sprite)
		print("life",life)
	if sprite and enemy_data.sprite:
		sprite.texture = enemy_data.sprite
func _physics_process(delta: float) -> void:
	target = Manager.player_pos
	if target:
		var direction = (target-global_position).normalized()
		velocity = direction*enemy_speed
	move_and_slide()
func _on_timer_timeout() -> void:
	pass
