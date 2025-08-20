extends Node2D

@onready var cronometro := $Cronometro
@onready var numbers := $Numeros # adicionado pro teste dos numeros aleatorios


func _ready() -> void:
	pass

func _on_button_pressed() -> void:
	cronometro.start()
	numbers.gerar() # adicionado pro teste de numeros aleatorios

	$Button.disabled = true
	$Button.visible = false
	
func on_numero_comido(valor:int) -> void:
	# aqui depois valida com o pivô e regras
	numbers.gerar()  #  depois de comer e validar, os numeros novos aparecem
