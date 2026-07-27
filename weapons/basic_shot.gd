extends base_weapon
var direction = Vector2.RIGHT
var time_to_die:float = 2.0
var speed = 200
func _ready() -> void:
	super._ready() # Importante: não chama os outros itens
	weapon_damage = Manager.basic_shot_damage # Dano fixo do tiro básico
	pierce = false

func _physics_process(delta: float) -> void:
	global_position+=speed*direction*delta
