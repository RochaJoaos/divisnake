extends Control

	
func _on_continuar_pressed() -> void:
	visible = false
	
func _on_menu_inicial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Menuinicial.tscn")
