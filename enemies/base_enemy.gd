class_name BaseEnemy

extends CharacterBody2D
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
func _ready() -> void:
	enemy_data_list = [enemy_bat,enemy_ghost,enemy_skull,enemy_mage]
	print("enemydata",enemy_data_list)
	var enemy_data = enemy_data_list.pick_random()
	if enemy_data:
		#stats
		enemy_name=enemy_data.enemy_name
		life=enemy_data.life
		damage=enemy_data.damage
		#texture	
	if sprite and enemy_data.sprite:
		sprite.texture = enemy_data.sprite
		sprite.hframes = enemy_data.h_frames
		sprite.vframes = enemy_data.v_frames
		anim_player.play("idle")
		#print("Nome do inimigo carregado: ", enemy_name)
		#print("Textura no Resource: ", enemy_data.sprite)
		#print("life",life)
func make_xp_drop():
	var drop_chance = randf()
	if drop_chance<=0.5:
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
