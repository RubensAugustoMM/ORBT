class_name GerenciadorCorposEstelares extends Node2D

var corpo_estelar_packed := preload("res://src/CorpoEstelar/CorpoEstelar.tscn")
var caminho_corpos := "res://Recursos/CorposEstelares.json"
var caminho_sprites := "res://Recursos/Sprites/"

var registro_corpos : Dictionary[String, CorpoEstelarRes] = {}


func _ready() -> void:
	GLOBAL.gerenciador_corpos_estelares = self
	carregar_corpos()


func carregar_corpos() -> void:
	if  not FileAccess.file_exists(caminho_corpos):
		return # lançar excessão
	
	var corpos = JSON.parse_string(FileAccess.get_file_as_string(caminho_corpos))

	for nome_corpo in corpos: 
		if not nome_corpo:
			continue
		if registro_corpos.has(nome_corpo):
			continue

		var propriedades = corpos[nome_corpo]
		var corpo_res := CorpoEstelarRes.new() 
		corpo_res.nome = nome_corpo
		corpo_res.sprite = load(caminho_sprites + propriedades["sprite"])
		corpo_res.raio_colisao = propriedades["raio_colisao"]
		corpo_res.raio_gravidade = propriedades["raio_gravidade"]
		corpo_res.forca_gravidade = propriedades["forca_gravidade"]
		corpo_res.estatico = propriedades["estatico"]
		corpo_res.objetivo = propriedades["objetivo"]
		registro_corpos[nome_corpo] = corpo_res
	

func obter_corpo(nome : String) -> CorpoEstelarRes:
	return registro_corpos[nome]


func adicionar_corpo_estelar(nodo : Node2D, corpo_estelar : CorpoEstelarRes, pos : Vector2) -> void:
	var instancia = corpo_estelar_packed.instantiate()
	instancia.corpo_estelar_res = corpo_estelar
	instancia.position = pos
	nodo.add_child(instancia)
