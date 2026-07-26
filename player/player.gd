extends CharacterBody2D
@export var proj_scene:PackedScene
@export var candle_scene:PackedScene
@export var water_scene:PackedScene
@export var pierce_scene:PackedScene
@export var dead_scene:PackedScene
@onready var squad = $rotate_pivot/squad
@onready var holyline = $holy_line
const SPEED = 200.0
@onready var lifebar = $lifebar/bar
signal  xp_collected(value:int)
func  _ready() -> void:
	Manager.player_pos = global_position
	lifebar.max_value = 100
	lifebar.min_value = 0
	lifebar.value=100
	squad.visible = true
	#create_circle()
	$Timer.start()
	$rotate_timer.start()
func _physics_process(delta: float) -> void:
	lifebar.value
	Manager.player_pos = global_position
	var mv = SPEED*Manager.move_speed
	var direction := Input.get_vector("left", "right","up","down")
	if direction:
		velocity = direction * mv
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
func create_projectile(spread_angle:float):
	var start_angle = spread_angle
	var angle_offset = spread_angle/max(1,Manager.projectile_count-1)
	for i in range(Manager.projectile_count):	
		var inst = proj_scene.instantiate()
		inst.global_position = $attack_pivot.global_position
		var current_angle = start_angle + (angle_offset*i)
		inst.direction = Vector2.RIGHT.rotated(deg_to_rad(current_angle))
		#print("coords",inst.global_position)
		get_tree().current_scene.add_child(inst)

func create_orbit(spread_angle:float):
	#for i in range(projectile_count):	
	var count = 0 
	count+=Manager.projectile_count
	for i in range(count):
		var inst = candle_scene.instantiate()
		var local_position = squad.get_point_position(i)
		inst.position = local_position
		squad.add_child(inst)

func create_water():
	#for i in range(projectile_count):	
	var count = 0 
	count+=Manager.projectile_count
	for i in range(count):
		var inst = water_scene.instantiate()
		var local_position = holyline.get_point_position(i)
		inst.position = local_position
		holyline.add_child(inst)

func create_pierceshot(spread_angle:float):
	var start_angle = spread_angle
	var angle_offset = spread_angle/max(1,Manager.projectile_count-1)
	for i in range(Manager.projectile_count):	
		var inst = pierce_scene.instantiate()
		inst.global_position = $attack_pivot.global_position
		var current_angle = start_angle + (angle_offset*i)
		inst.direction = Vector2.RIGHT.rotated(deg_to_rad(current_angle))
		#inst.connect("target_signal",_on_proj_timer_timeout)
		#print("coords",inst.global_position)
		get_tree().current_scene.add_child(inst)
func rotate_candle():
	#rotacionar o squad
	$rotate_pivot.rotate(20)
func _on_proj_timer_timeout() -> void:
	
	create_projectile(180)
	create_orbit(180)
	create_water()
	create_pierceshot(180)
	
func dead_screen():
	var inst = dead_scene.instantiate()
	get_tree().current_scene.add_child(inst)
func player_take_damage():
	lifebar.value -= 20
	if lifebar.value<=0:
		dead_screen()		
	elif lifebar.value<=0 and Manager.revive_stack==1:
		lifebar.value = 100
func _on_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		player_take_damage()

func _on_player_area_entered(area: Area2D) -> void:
	if area.is_in_group("drop_xp"):
		#print("adiciona 1 á barra de xp")
		emit_signal("xp_collected",100)
		area.queue_free()


func _on_rotate_timer_timeout() -> void:
	rotate_candle()
