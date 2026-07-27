class_name BaseEnemy

extends CharacterBody2D
@export var enemy_scene: PackedScene
@export var drop_scene:PackedScene
var enemy_speed = 10
var target = null
@export var enemy_bat:EnemyData
@export var enemy_ghost:EnemyData
@export var enemy_skull:EnemyData
@export var enemy_mage:EnemyData
var enemy_data_list = []

@onready var timer = $Timer
var life:int
var damage:int
@onready var anim_player: AnimationPlayer = $AnimationPlayer
var enemy_name:String
@onready var sprite: Sprite2D = $Sprite2D

# Variável para controlar o tempo global do jogo (caso você já tenha um Manager.tempo, ajuste aqui)

func _process(delta: float) -> void:
	Manager.tempo_jogado += delta

func _ready() -> void:
	enemyArray_setup()

func enemyArray_setup() -> void:
	enemy_data_list = [enemy_bat, enemy_ghost, enemy_skull, enemy_mage]
	
	var enemy_data = null
	
	# LINHA DO TEMPO RÁPIDA (Cadenciada por segundos corridos):
	# 0 a 150 segundos (Até 2.5 min): Só Morcego (índice 0)
	# 150 a 300 segundos (2.5 a 5 min): Morcego ou Fantasma
	# Acima disso: Libera todos
	if Manager.tempo_jogado < 150.0:
		enemy_data = enemy_bat
	elif Manager.tempo_jogado < 300.0:
		enemy_data = enemy_ghost
	elif Manager.tempo_jogado < 450.0:
		enemy_data = [enemy_skull,enemy_skull,enemy_skull,enemy_skull].pick_random()
	elif Manager.tempo_jogado > 450.0:
		enemy_data = [enemy_mage,enemy_mage,enemy_mage,enemy_mage].pick_random()
	
	if enemy_data:
		enemy_name = enemy_data.enemy_name
		life = enemy_data.life
		damage = enemy_data.damage
		
	if sprite and enemy_data and enemy_data.sprite:
		sprite.texture = enemy_data.sprite
		sprite.hframes = enemy_data.h_frames
		sprite.vframes = enemy_data.v_frames
		if anim_player and anim_player.has_animation("idle"):
			anim_player.play("idle")
func make_xp_drop():
	var drop_chance = randf()
	if drop_chance<=0.9:
		var inst = drop_scene.instantiate()
		inst.global_position = global_position	
		get_tree().current_scene.add_child(inst)
var tween:Tween		
func white_on_hit():
	
	if tween and tween.is_valid():
		tween.kill()
	$Sprite2D.modulate = Color(5, 5, 5, 1)
	tween = create_tween()
	tween.tween_property($Sprite2D,"modulate",Color.WHITE,0.1)

func enemy_take_damage(damage_value:int):
	life-= damage_value + Manager.damage_bonus
	print("dano tomado",life)
	white_on_hit()
	var explo = get_node_or_null("explosion")
	if life<=0:
		
		if explo:
			explo.reparent(get_tree().current_scene)
			explo.emitting = true
			make_xp_drop()
		$Sprite2D.visible =false
		await get_tree().create_timer(0.3).timeout
		queue_free()

func _physics_process(delta: float) -> void:
	target = Manager.player_pos
	if target:
		var direction = (target-global_position).normalized()
		velocity = direction*enemy_speed
	move_and_slide()
func _on_timer_timeout() -> void:
	pass
