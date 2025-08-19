extends Node2D

@export var cronometro_path: NodePath
@onready var cronometro := get_node(cronometro_path)

func _ready() -> void:
	pass

func _on_button_pressed() -> void:
	cronometro.start()
	$Button.disabled = true
	$Button.visible = false
