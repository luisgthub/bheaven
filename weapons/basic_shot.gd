extends base_weapon
var direction = Vector2.RIGHT
var time_to_die:float = 2.0
var speed = 20
func _ready() -> void:
	super._ready() # Importante: não chama os outros itens
	weapon_damage = 5 # Dano fixo do tiro básico
	
func shoot_distance():
	global_position+=10*direction
	pierce = false
	
#func _physics_process(delta: float) -> void:
#	global_position += direction*speed*delta
func _on_trajetory_timer_timeout() -> void:
	#print("soltei projetil")
	shoot_distance()
	pass
