class_name NivelRes extends Resource
# esta classe define um nível, o intuito é evitar criar níveis como xml's, res ou yaml(ainda não decidido qual) e simplesmente carrega-los atráves da classe GerenciadorDeNiveis
# idealmente os níveis serão criados utilizando um editor de níveis imbutido no jogo em si

@export var nome : String
@export var tamanho : Vector2
@export var inicio : Vector2
@export var fim : Vector2 # talvez alterar o fim para um nome de corpo estelar
@export var corpos_estelares : Dictionary[CorpoEstelarRes , Vector2] = {}
