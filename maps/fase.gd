extends Node2D
@export var enemy_scene:PackedScene
@export var upgrade_menu_scene: PackedScene
@onready var uihud = $xp
#exporta os resource.tres aqui
@export var bat:EnemyData
var enemyArray = [bat]
#pegar pontos
@onready var xpbar = $xp/xpbar
@onready var spawn_line = $enemySpawnLine

func _ready() -> void:
	$player.connect("xp_collected",_on_player_xp_collected)
	if uihud and uihud.has_signal("level_up"):
		uihud.level_up.connect(_on_player_level_up)
#XP AND UI 
func _on_player_level_up() -> void:
	print("Main recebeu o aviso de level up! Criando o menu na raiz...")
	
	if upgrade_menu_scene:
		# Instancia o menu garantindo que ele nasce na raiz principal da cena
		var menu_instancia = upgrade_menu_scene.instantiate()
		get_tree().current_scene.add_child(menu_instancia)
		
		if menu_instancia.has_method("mostrar_menu"):
			menu_instancia.mostrar_menu()
	else:
		print("ERRO: Atribua a cena do UpgradeMenu no Inspetor do nó Main!")
		
#WAVE CONFIG
func spawn_when_five():
	print("nasce monstro de um tipo")
func spawn_timer():
	var inst = enemy_scene.instantiate()
	inst.set("enemy_data", enemyArray[0])
	var random_spawn_point = randi_range(0,spawn_line.points.size()-1)
	var spawn_converted_point = spawn_line.points[random_spawn_point]
	inst.global_position = spawn_line.to_global(spawn_converted_point)
	#print("coords",inst.global_position)
	get_tree().current_scene.add_child(inst)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Manager.time_passed>=5:
		#spawn_timer()
	pass


func _on_timer_create_enemy_timeout() -> void:
	spawn_timer()	


func _on_player_xp_collected(value: int) -> void:
	xpbar.value +=value
