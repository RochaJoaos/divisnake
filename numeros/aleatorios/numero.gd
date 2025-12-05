extends Area2D

signal numero_comido(valor:int)

@export var valor:int = 0
@onready var som_numero = $"../som_numero" as AudioStreamPlayer

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D: # detecta a cobra
		numero_comido.emit(valor)
		call_deferred("queue_free") # some da tela quando é comido
 
