extends base_weapon

var time_to_die:float = 2.0
func _ready() -> void:
	super._ready() # Importante: não chama os outros itens
	weapon_damage = 5 # Dano fixo do tiro básico
	
func shoot_distance():
	global_position.x+=10
	pierce = false
func _on_trajetory_timer_timeout() -> void:
	#print("soltei projetil")
	shoot_distance()
