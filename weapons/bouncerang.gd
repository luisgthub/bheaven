extends base_weapon
var direction = Vector2.RIGHT
var time_to_die:float = 5.0
var speed = 100
@onready var raycast = $RayCast2D
var max_bounce:int = 3
var velocity:Vector2 = Vector2.ZERO
#signal target_signal(target_pos_value:Vector2)
func _ready() -> void:
	super._ready() # Importante: não chama os outros itens
	weapon_damage = Manager.bouncerang_damage # Dano fixo do tiro básico
	speed = speed*Manager.projectile_speed
	ricochete=true
	pierce=false
	
	velocity = direction.rotated(rotation)*speed
func _physics_process(delta: float) -> void:
	global_position+=velocity*delta
	rotation = velocity.angle()
	$Sprite2D.rotate(deg_to_rad(2))
	$CollisionShape2D.rotate(deg_to_rad(2))
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		global_position+=velocity*delta
		var colision_normal = raycast.get_collision_normal()
		if is_instance_valid(collider):
			velocity =velocity.bounce(colision_normal)
			global_position += velocity.normalized()
		max_bounce+=1
		if max_bounce<=3:
			call_deferred("queue_free")
func _on_trajetory_timer_timeout() -> void:
	call_deferred("queue_free")
