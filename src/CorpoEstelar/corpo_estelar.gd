extends RigidBody2D

# !!!!!esta propriedade deve ser definida ANTES de adicionar
# o nodo à árvore de nodos!!!!!!!!!!
@export var corpo_estelar_res : CorpoEstelarRes


@onready var colisao := $CollisionShape2D
@onready var sprite := $Sprite2D
@onready var area_gravidade := $Area2D/CollisionShape2D


func _ready() -> void:
	iniciar()


func iniciar() -> void:
	if corpo_estelar_res == null:
		return # lancar excessão
	
	
	freeze = corpo_estelar_res.estatico
	
	var forma_colisao := CircleShape2D.new()
	forma_colisao.radius = corpo_estelar_res.raio_colisao
	colisao.shape = forma_colisao
	sprite.texture = corpo_estelar_res.sprite
	
	var forma_gravidade := CircleShape2D.new() 
	forma_gravidade.radius = corpo_estelar_res.raio_gravidade
	area_gravidade.shape = forma_gravidade
