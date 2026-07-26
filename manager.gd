extends Node

var player_pos:Vector2
var time_passed:float
var game_running = false

#upgrade attributes
var move_speed = 1
var revive_stack = 0
var area_of_effect = 1
var projectile_count = 1
var magnet_area = 1
var damage_bonus = 1
var candle_damage = 10
var basic_shot_damage = 5
var holy_damage = 5
var bone_damage = 5

@export var all_upgrades: Array[UpgradeData] = [
	preload("res://upgrades/basic.tres"),
	preload("res://upgrades/bone_weapon.tres"),
	preload("res://upgrades/candle_weapon.tres"),
	preload("res://upgrades/holywater.tres"),
	preload("res://upgrades/damage.tres"),
	preload("res://upgrades/increase_area.tres"),
	preload("res://upgrades/magnet_area.tres"),
	preload("res://upgrades/move_speed.tres"),
	preload("res://upgrades/plus_projectile.tres"),
	preload("res://upgrades/revive.tres")
]

func apply_upgrade(id_upgrade:String):
	for upgrade in all_upgrades:
		if upgrade.upgrade_id == id_upgrade:
			upgrade.current_level +=1
			match id_upgrade:
					"move":
						move_speed *=1.2
					"dama":
						damage_bonus*=1.1
					"area":
						area_of_effect*=1.1
					"proj":
						projectile_count+=1
					"magnet":
						magnet_area*=1.2
					"revive":
						revive_stack=1
					"basic":
						basic_shot_damage+=10
					"candle":
						candle_damage+=10
					"bone":
						bone_damage+=10
					"holy":
						holy_damage+=10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_running = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		time_passed+=delta
		#print("ps",time_passed)
	pass
