extends CanvasLayer

@onready var btn_container = $CenterContainer/HBoxContainer
@onready var text_place = $"bottom-center"
func _ready() -> void:
	visible=true
	process_mode = Node.PROCESS_MODE_ALWAYS
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
		print("Criando opção para o upgrade: ", upgrade.upgrade_name)
		
		# 1. Container vertical
		var vbox = VBoxContainer.new()
		vbox.custom_minimum_size = Vector2(80, 120)
		# IMPORTANTE: Faz o container ignorar o mouse para não bloquear os filhos
		vbox.mouse_filter = Control.MOUSE_FILTER_PASS
		
		# 2. Botão com o ícone (fica em cima)
		var btn = TextureButton.new()
		btn.custom_minimum_size = Vector2(36, 36)
		btn.ignore_texture_size = true
		btn.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		btn.texture_normal = upgrade.upgrade_icon
		# O botão DEVE capturar o mouse para ser clicável
		btn.mouse_filter = Control.MOUSE_FILTER_STOP
		
		# 3. Label com a descrição (fica abaixo do ícone)
		var label = Label.new()
		label.text = upgrade.skill_description
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		label.add_theme_font_size_override("font_size", 4)
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		# IMPORTANTE: O label também deve ignorar o mouse para não roubar o clique do botão (se estivessem sobrepostos)
		label.mouse_filter = Control.MOUSE_FILTER_STOP
		
		# 4. Conecta os cliques do botão
		btn.pressed.connect(func(): selecionar_upgrade(upgrade.upgrade_id))
		btn.pressed.connect(func(): on_button_pressed(upgrade.upgrade_id, upgrade.skill_description))
		
		# 5. Monta a hierarquia
		vbox.add_child(btn)
		vbox.add_child(label)
		btn_container.add_child(vbox)		
		vbox.move_child(btn, 0)
func selecionar_upgrade(id_upgrade: String) -> void:
	Manager.apply_upgrade(id_upgrade)
	get_tree().paused = false
	queue_free()
	
func on_button_pressed(id_upgrade: String, description: String):
	print("Clicou no upgrade: ", id_upgrade)
	print("Descrição dele: ", description)
	# Faz o Label da parte de baixo mudar para a descrição do botão que você clicou!
	if has_node("bottom-center/Label"):
		$"bottom-center/Label".text = description
	
