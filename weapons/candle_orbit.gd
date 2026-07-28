extends base_weapon


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready() # Importante: não chama os outros itens
	weapon_damage = Manager.candle_damage# Dano fixo do tiro básico
	pierce = true
	ricochete = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
