extends Area2D
class_name base_weapon
@onready var timer = $Timer
var pierce:bool = false
var ricochete:bool = false
@export var weapon_damage = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_trajetory_timer_timeout() -> void:
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("objeto deletado")
	queue_free()

func _on_enemy_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if body.has_method("enemy_take_damage"):
			body.enemy_take_damage(weapon_damage)
			if not pierce and not ricochete:
				call_deferred("queue_free")
			else:
				pass
