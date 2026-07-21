extends Node2D
@export var enemy_scene:PackedScene
#pegar pontos
@onready var spawn_line = $enemySpawnLine
func spawn_when_five():
	print("nasce monstro de um tipo")
func spawn_timer():
	var inst = enemy_scene.instantiate()
	var random_spawn_point = randi_range(0,spawn_line.points.size()-1)
	var spawn_converted_point = spawn_line.points[random_spawn_point]
	inst.global_position = spawn_line.to_global(spawn_converted_point)
	#print("coords",inst.global_position)
	get_tree().current_scene.add_child(inst)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Manager.time_passed>=5:
		#spawn_timer()
	pass


func _on_timer_create_enemy_timeout() -> void:
	spawn_timer()	
