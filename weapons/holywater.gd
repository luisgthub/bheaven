extends base_weapon

var direction = Vector2.DOWN
var target_position: Vector2

func _ready() -> void:
	super._ready()
	weapon_damage = Manager.holy_damage
	pierce = true
	ricochete = false
	
	# 1. Define um tempo aleatório para o timer (se já não estiver configurado no Inspetor)
	$Timer.wait_time = randf_range(0.5, 2.0)
	$Timer.one_shot = true
	$Timer.start()
	
	# 2. Sorteia uma posição aleatória ao redor do player para a garrafa cair
	# (Exemplo: cai num raio de até 200 pixels de distância do jogador)
	var random_offset = Vector2(randf_range(-200, 200), randf_range(-200, 200))
	
	# Se você quiser que caia um pouco mais acima (simulando que veio do teto):
	global_position = Manager.player_pos + random_offset + Vector2(0, -300)
	target_position = Manager.player_pos + random_offset

var speed = 200 # Velocidade de queda da garrafa

func _physics_process(delta: float) -> void:
	# Faz a garrafa cair em direção ao chão/ponto sorteado
	global_position = global_position.move_toward(target_position, speed * delta)
	
	# Se chegou no destino, cria a poça de fogo e some com a garrafa
	if global_position.distance_to(target_position) < 5:
		criar_poca_fogo()
		queue_free()

func criar_poca_fogo():
	# Aqui você pode instanciar a cena do fogo sagrado no chão, por exemplo:
	# var fire_inst = holy_fire_scene.instantiate()
	# fire_inst.global_position = global_position
	# get_tree().current_scene.add_child(fire_inst)
	print("Garrafa quebrou e criou poça em: ", global_position)

func _on_trajetory_timer_timeout() -> void:
	call_deferred("queue_free")
