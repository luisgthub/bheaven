extends Control

@onready var xpbar = $xpbar
var level = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = 1
	$level.text = "level "+str(level)

func _process(delta: float) -> void:
	if xpbar.value>= xpbar.max_value:
		xpbar.value = 0
		level +=1
		$level.text = "level "+str(level)
		xpbar.max_value+=20
