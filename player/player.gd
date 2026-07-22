extends CharacterBody2D
@export var proj_scene:PackedScene
@export var dead_scene:PackedScene
const SPEED = 200.0
@onready var lifebar = $lifebar/bar
signal  xp_collected(value:int)
func  _ready() -> void:
	Manager.player_pos = global_position
	lifebar.max_value = 100
	lifebar.min_value = 0
	lifebar.value=100
	$Timer.start()
func _physics_process(delta: float) -> void:
	lifebar.value
	Manager.player_pos = global_position
	var direction := Input.get_vector("left", "right","up","down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
func create_projectile():
	var inst = proj_scene.instantiate()
	inst.global_position = $attack_pivot.global_position
	print("coords",inst.global_position)
	get_tree().current_scene.add_child(inst)

func _on_proj_timer_timeout() -> void:
	create_projectile()

func dead_screen():
	var inst = dead_scene.instantiate()
	get_tree().current_scene.add_child(inst)
func player_take_damage():
	lifebar.value -= 20
	if lifebar.value<=0:
		dead_screen()		
		
func _on_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		player_take_damage()

func _on_player_area_entered(area: Area2D) -> void:
	if area.is_in_group("drop_xp"):
		print("adiciona 1 á barra de xp")
		emit_signal("xp_collected",10)
		area.queue_free()
