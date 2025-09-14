extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func Botao_Jogar_press() -> void:
	get_tree().change_scene_to_file("res://scenes/game/main.tscn")


func Botao_opcoes_press() -> void:
	get_tree().change_scene_to_file("res://scenes/Opções.tscn")


func Botao_Creditos_press() -> void:
	get_tree().change_scene_to_file("res://scenes/Creditos.tscn")


func Botao_sair_press() -> void:
	get_tree().quit()
