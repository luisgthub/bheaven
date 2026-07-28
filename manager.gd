extends Node

var player_pos:Vector2
var time_passed:float
var game_running = false
var score:int = 0
#upgrade attributes
var move_speed = 1
var revive_stack = 0
var area_of_effect :Vector2
var projectile_count = 1
var pierce_count = 0
var holy_count = 0
var candle_count = 0
var bouncerang_count = 0
var killed:int = 0
var magnet_area = 1
var damage_bonus = 1
var candle_damage = 10
var basic_shot_damage = 5
var holy_damage = 5
var bone_damage = 5
var bouncerang_damage = 10
var projectile_speed = 1.0
static var tempo_jogado: float = 0.0

@export var all_upgrades: Array[UpgradeData] = [
	#preload("res://upgrades/basic.tres"),
	#preload("res://upgrades/bone_weapon.tres"),
	#preload("res://upgrades/candle_weapon.tres"),
	#preload("res://upgrades/holywater.tres"),
	preload("res://upgrades/damage.tres"),
	preload("res://upgrades/increase_area.tres"),
	preload("res://upgrades/move_speed.tres"),
	preload("res://upgrades/projectile_speed.tres"),
	preload("res://upgrades/revive.tres"),
	preload("res://upgrades/basic_plus.tres"),
	preload("res://upgrades/boneplus.tres"),
	preload("res://upgrades/candle_plus.tres"),
	#preload("res://upgrades/holyplus.tres"),
	preload("res://upgrades/rangplus.tres")
]

func apply_upgrade(id_upgrade:String):
	for upgrade in all_upgrades:
		if upgrade.upgrade_id == id_upgrade:
			upgrade.current_level +=1
			match id_upgrade:
					"move":
						move_speed *=1.1
					"dama":
						damage_bonus*=1.1
					"area":
						area_of_effect+=Vector2(0.2,0.2)
					"proj-count":
						projectile_count+=1
					"holy-count":
						holy_count+=1
					"pierce-count":
						pierce_count+=1
					"candle-count":
						candle_count+=1
					"revive":
						revive_stack+=1
					"basic":
						basic_shot_damage+=10
					"candle":
						candle_damage+=10
					"bone":
						bone_damage+=10
					"holy":
						holy_damage+=10
					"bone-weapon":
						pierce_count+=1
					"candle-weapon":
						candle_count+=1
					"holy-weapon":
						holy_count+=1
					"rang-plus":
						bouncerang_count+=1
					"proj-speed":
						projectile_speed*=1.1
					"rang-damage":
						bouncerang_damage+=10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_running = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		time_passed+=delta
		#print("ps",time_passed)
	pass
