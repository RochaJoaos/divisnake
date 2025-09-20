extends CharacterBody2D

var direction: Vector2 = Vector2.RIGHT
var cell_size: int = 36
var move_timer: float = 0.5 # tempo entre movimentos (velocidade da cobra)
@export var start : bool = false
@onready var head : Sprite2D = $Sprite2D

func _ready():
	# Garante que a cobra comece alinhada ao grid
	position = position.snapped(Vector2(cell_size, cell_size))

func _process(delta):
	get_input()
	
	move_timer -= delta
	if move_timer <= 0:
		move_timer = 0.5 # reseta o timer
		move_snake()

func get_input():
	if Input.is_action_just_pressed("ui_right") and direction != Vector2.LEFT:
		direction = Vector2.RIGHT
		head.texture = load("res://assets/sprites/snake/head/yellow_head_right.png")
	elif Input.is_action_just_pressed("ui_left") and direction != Vector2.RIGHT:
		direction = Vector2.LEFT
		head.texture = load("res://assets/sprites/snake/head/yellow_head_left.png")
	elif Input.is_action_just_pressed("ui_up") and direction != Vector2.DOWN:
		direction = Vector2.UP
		head.texture = load("res://assets/sprites/snake/head/yellow_head_up.png")
	elif Input.is_action_just_pressed("ui_down") and direction != Vector2.UP:
		direction = Vector2.DOWN
		head.texture = load("res://assets/sprites/snake/head/yellow_head_down.png")
func move_snake():
	if start:
		position += direction * cell_size
