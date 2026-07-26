extends Control

# Mude a referência para o seu HBoxContainer na cena
@onready var btn_container = $CenterContainer/HBoxContainer
func _ready() -> void:
	visible = true
	set_process_input(false)
	
func mostrar_menu() -> void:
	get_tree().paused = true   # Pausa o jogo
	visible = true             # Mostra o painel do menu na tela
	atualizar_opcoes_visuais() # Gera os botões atualizados
	
func atualizar_opcoes_visuais() -> void:
	# Limpa os botões antigos antes de criar novos
	for child in btn_container.get_children():
		child.queue_free()
		
	var upgrades_filtrados: Array[UpgradeData] = []
	
	for upgrade in Manager.all_upgrades:
		if upgrade.current_level < upgrade.max_level:
			upgrades_filtrados.append(upgrade)
			
	if upgrades_filtrados.is_empty():
		visible = false
		get_tree().paused = false
		return
		
	upgrades_filtrados.shuffle()
	
	for i in range(min(3, upgrades_filtrados.size())):
		var upgrade: UpgradeData = upgrades_filtrados[i]
		
		# Cria o botão dinamicamente
		var btn = TextureButton.new()
		btn.text = upgrade.upgrade_name + " (Nv. " + str(upgrade.current_level + 1) + ")\n"
		btn.texture_normal = upgrade.upgrade_icon
		$"bottom-center/Label".text = upgrade.skill_description
		# Dica para HBox: dê um tamanho mínimo horizontal bom para o texto não ficar espremido
		#btn.custom_minimum_size = Vector2(180, 100)
		
		# Conecta o clique do botão
		btn.pressed.connect(func(): selecionar_upgrade(upgrade.upgrade_id))
		
		# Adiciona o botão dentro do HBoxContainer
		btn_container.add_child(btn)

func selecionar_upgrade(id_upgrade: String) -> void:
	Manager.aplicar_upgrade(id_upgrade)
	visible = false
	get_tree().paused = false
