extends CanvasLayer

@onready var btn_container = $CenterContainer/HBoxContainer
@onready var text_place = $"bottom-center"
@onready var labels_scene = preload("res://Square_text.tscn")
func _ready() -> void:
	visible=true
	pass

# Chame esta função logo após instanciar no Main
func mostrar_menu() -> void:
	visible = true             # FORÇA O MENU A FICAR VISÍVEL
	get_tree().paused = true   # Pausa o jogo
	atualizar_opcoes_visuais() 
func atualizar_opcoes_visuais() -> void:
	for child in btn_container.get_children():
		child.queue_free()
		
	var upgrades_filtrados: Array[UpgradeData] = []
	
	for upgrade in Manager.all_upgrades:
		print("Checando upgrade: ", upgrade.upgrade_name, " | Nível atual: ", upgrade.current_level, " / Max: ", upgrade.max_level)
		if upgrade.current_level < upgrade.max_level:
			upgrades_filtrados.append(upgrade)
			
	print("Total de upgrades filtrados para mostrar: ", upgrades_filtrados.size())
			
	if upgrades_filtrados.is_empty():
		print("ATENÇÃO: Nenhum upgrade disponível para mostrar!")
		get_tree().paused = false
		queue_free()
		return
		
	upgrades_filtrados.shuffle()
	
	for i in range(min(3, upgrades_filtrados.size())):
		var upgrade: UpgradeData = upgrades_filtrados[i]
		print("Criando botão para o upgrade: ", upgrade.upgrade_name)
		
		var btn = TextureButton.new()
		btn.custom_minimum_size = Vector2(32,32)
		btn.ignore_texture_size = true
		btn.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		btn.texture_normal = upgrade.upgrade_icon
		
		btn.pressed.connect(func(): selecionar_upgrade(upgrade.upgrade_id))
		btn.pressed.connect(func(): on_button_pressed(upgrade.upgrade_id,upgrade.skill_description))
		btn_container.add_child(btn)
		
func selecionar_upgrade(id_upgrade: String) -> void:
	Manager.apply_upgrade(id_upgrade)
	get_tree().paused = false
	queue_free()
	
func show_skill_info(description):
	print("info", description)
	var inst = labels_scene.instantiate()
		# Procura o Label dentro da cena instanciada (supondo que ele se chame "Label")
	var label_interno = inst.get_node("Label") # Ajuste o caminho/nome se for diferente
	if label_interno:
		label_interno.text = description
			
	text_place.add_child(inst)
	
func on_button_pressed(id_upgrade: String, description: String):
	print("Clicou no upgrade: ", id_upgrade)
	print("Descrição dele: ", description)
	# Faz o Label da parte de baixo mudar para a descrição do botão que você clicou!
	if has_node("bottom-center/Label"):
		$"bottom-center/Label".text = description
		
	# Ou se você estiver usando a sua cena instanciada (text_place):
	show_skill_info(description)
	# Faça o que precisar com a descrição aqui, por exemplo, jogar num Label:
