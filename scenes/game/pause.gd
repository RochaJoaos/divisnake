extends Control

	
func _on_continuar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/main.tscn")
	
func _on_menu_inicial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/inicial/Menuinicial.tscn")
	
func _on_regras_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/regras/Regras.tscn")

func _on_configuração_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/opcoes/Opções.tscn")
