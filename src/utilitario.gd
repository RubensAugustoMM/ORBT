extends Node

# deserializa(sei lá se escreve assim) um vetor
# seguindo o modelo do projeto 
# neste caso, um dicionário json {"x": num, "y": num}
func deserializar_vetor(dic) -> Vector2:
	return Vector2(dic["x"], dic["y"])
