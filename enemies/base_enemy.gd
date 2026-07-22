class_name BaseEnemy

extends CharacterBody2D
@export var drop_scene:PackedScene
var enemy_speed = 10
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
func make_xp_drop():
	var drop_chance = randf()
	if drop_chance<=0.5:
		var inst = drop_scene.instantiate()
		inst.global_position = global_position	
		get_tree().current_scene.add_child(inst)
		
func enemy_take_damage(damage_value:int):
	life-= damage_value
	print("dano tomado",life)
	var explo = get_node_or_null("explosion")
	if life<=0:
		
		if explo:
			explo.reparent(get_tree().current_scene)
			explo.emitting = true
			make_xp_drop()
		queue_free()
		
func _physics_process(delta: float) -> void:
	target = Manager.player_pos
	if target:
		var direction = (target-global_position).normalized()
		velocity = direction*enemy_speed
	move_and_slide()
func _on_timer_timeout() -> void:
	pass
