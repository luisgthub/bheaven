extends base_weapon


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready() # Importante: não chama os outros itens
	weapon_damage = 5 # Dano fixo do tiro básico
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
