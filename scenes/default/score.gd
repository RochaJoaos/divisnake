extends Control

@export var ponto_cada_acerto: int = 10
@export var ponto_total: int = 1000

@onready var score_label: Label = $Label
@onready var gameover := $"../.."

var pontos: int = 0 : set = _set_pontos, get = _get_pontos


signal score_aumenta(points: int)
signal vitoria_score(points: int)

func _ready() -> void:
	add_to_group("score_script")
	_atualiza_label()

func reset() -> void:
	pontos = 0
	_atualiza_label()
	emit_signal("score_aumenta", pontos)

func resultado(acertou: bool) -> void:
	if acertou:
		pontos += ponto_cada_acerto
		_atualiza_label()
		emit_signal("score_aumenta", pontos)

		if pontos >= ponto_total:
			emit_signal("vitoria_score", pontos)
			get_tree().change_scene_to_file("res://scenes/game/game_over.tscn")

func _atualiza_label() -> void:
	if is_instance_valid(score_label):
		score_label.text = "%03d" % pontos

func _set_pontos(v: int) -> void:
	pontos = max(0, v)

func _get_pontos() -> int:
	return pontos
