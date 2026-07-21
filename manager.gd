extends Node

var player_pos:Vector2
var time_passed:float
var game_running = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_running = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		time_passed+=delta
		#print("ps",time_passed)
	pass
