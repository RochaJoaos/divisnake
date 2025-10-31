extends Control

@onready var vel: float = 0.3
var rapido: float = 0.1
var normal: float = 0.3
var lento: float = 1
@onready var btn_vel := $"menu/p-velocidade/btn-velocidade"
@onready var snake := $snake
signal snake_vel(speed: float)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	



func _on_btnvelocidade_pressed() -> void:
	if is_equal_approx(vel, normal):
		btn_vel.text = "rápido"
		vel = rapido
		emit_signal("snake_vel", vel)
	elif is_equal_approx(vel, rapido):
		btn_vel.text = "lento"
		vel = lento
		emit_signal("snake_vel", vel)
	elif is_equal_approx(vel, lento):
		btn_vel.text = "normal"
		vel = normal
		emit_signal("snake_vel", vel)
		
	
		
