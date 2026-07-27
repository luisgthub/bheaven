extends CanvasLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#teste
func _process(delta: float) -> void:
	pass

func _on_restart_pressed() -> void:
	# 1. Reseta todos os atributos do Manager para os valores iniciais
	Manager.player_pos = Vector2.ZERO
	Manager.time_passed = 0.0
	Manager.game_running = false

	Manager.move_speed = 1
	Manager.revive_stack = 0
	Manager.area_of_effect = Vector2.ZERO # ou Vector2(1,1) dependendo de como usa
	Manager.projectile_count = 1
	Manager.pierce_count = 0
	Manager.holy_count = 0
	Manager.candle_count = 0

	Manager.magnet_area = 1
	Manager.damage_bonus = 1
	Manager.candle_damage = 10
	Manager.basic_shot_damage = 5
	Manager.holy_damage = 5
	Manager.bone_damage = 5
	Manager.tempo_jogado = 0.0
	
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")
	self.queue_free()
