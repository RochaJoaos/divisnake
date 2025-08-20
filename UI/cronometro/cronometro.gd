extends Label

@export var auto_start: bool = false   
var tempo: float = 0.0                
var rodando: bool = false

func _ready() -> void:
	text = "00:00"
	if auto_start:
		start()

func _process(delta: float) -> void:
	if not rodando:
		return
	tempo += delta
	_atualiza_texto()

func start() -> void:
	rodando = true

func pause() -> void:
	rodando = false

func reset() -> void:
	rodando = false
	tempo = 0.0
	_atualiza_texto()

func _atualiza_texto() -> void:
	var m := int(tempo) / 60
	var s := int(tempo) % 60
	text = "%02d:%02d" % [m, s]
