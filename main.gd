extends Node2D
@onready var game_won = preload("res://menus/won.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func game_won_call():
	var inst = game_won.instantiate()
	get_tree().current_scene.add_child(inst)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var strnum = String.num(Manager.time_passed,1)
	$Label.text = "Time: " + strnum
	if Manager.time_passed>= 300:
		game_won_call()
