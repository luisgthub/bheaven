extends Area2D
class_name base_weapon
@onready var timer = $Timer
var pierce:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	timer.autostart = true
	
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
		if pierce:
			body.queue_free()
		else:
			body.queue_free() 
			queue_free()
