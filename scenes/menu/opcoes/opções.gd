extends Control

@onready var vel: float = 0.3
var rapido: float = 0.1
var normal: float = 0.3
var lento: float = 0.5

@onready var btn_vel := $"menu/p-velocidade/btn-velocidade"
@onready var btn_som := $"menu/p-som/btn-som" 
@onready var snake := $snake

signal snake_vel(speed: float)


func _ready() -> void:
	# ----- VELOCIDADE -----
	if is_equal_approx(Global.snake_velocity, normal):
		btn_vel.text = "normal"
	elif is_equal_approx(Global.snake_velocity, rapido):
		btn_vel.text = "rápido"
	elif is_equal_approx(Global.snake_velocity, lento):
		btn_vel.text = "lento"

	vel = Global.snake_velocity

	# ----- SOM -----
	atualizar_botao_som()

	btn_vel.pressed.connect(_on_btnvelocidade_pressed)
	btn_som.pressed.connect(_on_btnsom_pressed)


func _process(delta: float) -> void:
	pass


# ------------------- VELOCIDADE -------------------
func _on_btnvelocidade_pressed() -> void:
	if is_equal_approx(vel, normal):
		btn_vel.text = "rápido"
		vel = rapido
	elif is_equal_approx(vel, rapido):
		btn_vel.text = "lento"
		vel = lento
	else:
		btn_vel.text = "normal"
		vel = normal

	Global.snake_velocity = vel
	emit_signal("snake_vel", vel)


# ------------------- SOM ON/OFF -------------------
func _on_btnsom_pressed() -> void:
	Global.som_ligado = !Global.som_ligado
	atualizar_botao_som()


func atualizar_botao_som() -> void:
	if Global.som_ligado:
		btn_som.text = "ON"
	else:
		btn_som.text = "OFF"

	var idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(idx, !Global.som_ligado)
