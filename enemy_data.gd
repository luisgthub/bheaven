class_name EnemyData
extends Resource

@export var enemy_name:String
@export var life:int
@export var damage:int


@export_group("sprite_visual")
@export var sprite:Texture2D
@export var h_frames: int = 3 # Como todos têm 3 frames, você já pode deixar padrão aqui se quiser!
@export var v_frames: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
