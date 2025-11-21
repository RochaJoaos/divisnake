extends Control

@onready var score := $score/scorepanel/Label
@onready var tempo := $score/Cronometro

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = "%03d" % Global.records
	tempo.text = Global.tempo


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_reiniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/main.tscn")
	
func _on_menu_inicial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/inicial/Menuinicial.tscn")

func _on_regras_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/regras/Regras.tscn")


func _on_configuração_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/opcoes/Opções.tscn")
