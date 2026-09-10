extends Node2D


# nodo dos objetos estaticos
@onready var objetos_estaticos = $Estaticos
# nodo dos objetos dinâmicos
@onready var objetos_dinamicos = $Dinamicos
# sinceramente não sei como funciona mas sei que é importante
# Pelo o que li, talvez seja melhor torna-lo um nodo da 
# cena main
@onready var world_environment = $WorldEnvironment
@onready var fim :=  $Estaticos/Fim
@onready var inicio := $Estaticos/Inicio

# !!!!!esta propriedade deve ser definida ANTES de adicionar
# o nodo à árvore de nodos!!!!!!!!!!
var nivel_res : NivelRes

func _ready() -> void:
	iniciar()

func iniciar() -> void:
	if nivel_res == null:
		return # lançar excessão

	fim.position = nivel_res.fim
	inicio.position = nivel_res.inicios
	
	for corpo in nivel_res.corpos_estelares:
		if not corpo:
			continue
		var pos = nivel_res.corpos_estelares[corpo]
		GLOBAL.gerenciador_corpos_estelares.adicionar_corpo_estelar(objetos_estaticos,corpo, pos)
