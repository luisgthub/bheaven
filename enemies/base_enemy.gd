extends CharacterBody2D
var enemy_speed = 30
var target = null
@onready var timer = $Timer
func _ready() -> void:
	#timer.autostart = true
	#timer.start()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	target = Manager.player_pos
	if target:
		var direction = (target-global_position).normalized()
		velocity = direction*enemy_speed
	move_and_slide()
func _on_timer_timeout() -> void:
	pass
