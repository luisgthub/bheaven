extends base_weapon
var direction = Vector2.DOWN
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready() # Importante: não chama os outros itens
	weapon_damage = 5 # Dano fixo do tiro básico
var max_limit = 100
func shoot_distance():
	var movement=20
	global_position.y+=movement
	if global_position.y<=60:
		queue_free()
var speed =50
func _physics_process(delta: float) -> void:
	global_position.y +=speed*delta
func _on_trajetory_timer_timeout() -> void:
	#print("soltei projetil")
	#shoot_distance()
	call_deferred("queue_free")
	pass
