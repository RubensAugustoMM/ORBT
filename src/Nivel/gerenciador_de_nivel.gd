class_name GerenciadorDeNivel extends Node2D

var nivel_packed := preload("res://src/Nivel/Nivel.tscn")
var caminho := "res://Recursos/Niveis.json"

var registro_niveis : Dictionary[String, NivelRes] = {}


func _ready() -> void:
	GLOBAL.gerendiador_de_nivel = self
	carregar_niveis() 


func carregar_niveis() -> void:
	if not FileAccess.file_exists(caminho):
		return # lançar excessão
	
	var niveis = JSON.parse_string(FileAccess.get_file_as_string(caminho))

	for nome_nivel in niveis:
		if not nome_nivel:
			continue
		if registro_niveis.has(nome_nivel):
			continue # nome duplicado
		
		var propriedades = niveis[nome_nivel]
		var nivel_res := NivelRes.new()
		nivel_res.nome = nome_nivel
		nivel_res.tamanho = UTILITARIO.deserializar_vetor(propriedades["tamanho"])
		nivel_res.inicio = UTILITARIO.deserializar_vetor(propriedades["inicio"])
		nivel_res.fim = UTILITARIO.deserializar_vetor(propriedades["fim"])
		
		for corpo in propriedades["corpos_estelares"]:
			if not corpo:
				continue
			if nivel_res.corpos_estelares.has(corpo):
				continue
			# adicionar verificação se o corpo existe
			var corpo_res : CorpoEstelarRes = GLOBAL.gerenciador_corpos_estelares.obter_corpo(corpo)
			var corpo_pos = propriedades["corpos_estelares"][corpo]
				
			nivel_res.corpos_estelares[corpo_res] = UTILITARIO.deserializar_vetor(corpo_pos)
		
		registro_niveis[nome_nivel] = nivel_res


func obter_nivel_res(nome : String) -> NivelRes:
	# Utilizando o metodo get ao inves de dict[key] pois get retorna null caso o dict nao
	# possuir uma entrada para a chave utilizada
	return registro_niveis.get(nome)
	

func obter_nivel_instancia(nome : String) -> Node2D:
	var nivel = nivel_packed.instantiate()
	nivel.nivel_res = obter_nivel_res(nome)
	return nivel
