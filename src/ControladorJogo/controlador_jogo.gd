class_name ControladorJogo extends Node
# Este script é o primeiro a ser rodado ao iniciar o jogo, na função _ready deste script deve ser realizado todas as funções de 
# Inicialização 
# Note também que este será o game controller, ou seja, uma máquina de estado que controla o jogo.
# Qualquer mudança de tela, requisição de estado do jogo, etc deve ser enviado para este nodo, e toda a carga e descarga
# de nodos deve ser realizada neste nodo
# Caso este acumular muitas funções, iremos separar em um Resourcemanager(Gerenciador de recursos) e um GameStateManager (Gerenciador
# de estado)

@onready var mundo = $Mundo
@onready var interface =  $Interface

# cena do mundo carregada no momento, pode ser o plano de fundo do menu, nível, etc etc
var mundo_atual  
# cena de interface atual, menu, seleção de níveis, etc
var interface_atual 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLOBAL.controlador_jogo = self
	if interface.get_child_count() != 0:
		interface_atual = interface.get_children().front()
	if mundo.get_child_count() != 0:
		mundo_atual = mundo.get_children().front()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func alterar_interface(interface_nova : String, deletar := false, manter_rodando := false) -> void:
	validar_interface_atual(deletar, manter_rodando)
	var interface_instancia = load(interface_nova)
	interface.add_child(interface_instancia)
	interface_atual = interface_instancia


func alterar_interface_nodo(interface_nova : Control, deletar := false, manter_rodando := false) -> void:
	validar_interface_atual(deletar, manter_rodando)
	interface.add_child(interface_nova)
	interface_atual = interface_nova
	

func validar_interface_atual(deletar : bool, manter_rodando : bool) -> void:
	if interface_atual != null:
		if deletar:
			interface_atual.queue_free()
		elif manter_rodando:
			interface_atual.visible = false
		else:
			interface.remove_child(mundo_atual)	


func alterar_mundo(mundo_novo : String, deletar : bool = false, manter_rodando : bool = false) -> void:
	validar_mundo_atual(deletar, manter_rodando)	
	var mundo_instancia = load(mundo_novo) 
	mundo.add_child(mundo_instancia)
	mundo_atual = mundo_instancia


func alterar_mundo_nodo(mundo_novo : Node2D, deletar : bool = false, manter_rodando : bool = false) -> void:
	validar_mundo_atual(deletar, manter_rodando)
	mundo.add_child(mundo_novo)
	mundo_atual = mundo_novo
	pass


func validar_mundo_atual(deletar : bool, manter_rodando : bool) -> void:
	if mundo_atual != null:
		if deletar:
			mundo_atual.queue_free()
		elif manter_rodando:
			mundo_atual.visible = false
		else:
			mundo.remove_child(mundo_atual)	
