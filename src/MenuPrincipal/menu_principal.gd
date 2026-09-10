extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	GLOBAL.controlador_jogo.alterar_interface_nodo(Control.new(), true)
	GLOBAL.controlador_jogo.alterar_mundo_nodo(GLOBAL.gerendiador_de_nivel.obter_nivel_instancia("teste_001"))
	
