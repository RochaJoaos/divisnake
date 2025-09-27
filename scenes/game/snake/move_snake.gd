extends CharacterBody2D

@export var direction: Vector2 = Vector2.RIGHT
var cell_size: int = 36
var move_timer: float = 0.5 # tempo entre movimentos (velocidade da cobra)
@export var start : bool = false
@onready var head : Sprite2D = $Sprite2D
@onready var Pause: Control = $"../UI_Pause/Pause"
@export var localsnake := Vector2(2, 4)

# --- corpo da cobra ---
var segment_scene = preload("res://scenes/game/snake/body-snake.tscn")
var body_parts: Array = []  # lista com os pedaços da cobra
var pending_growth: int = 0 # quantos segmentos devem ser adicionados

func _ready():
	position = position.snapped(Vector2(cell_size, cell_size))
	preload("res://scenes/game/snake/body-snake.tscn")

func _process(delta):
	get_input()
	move_timer -= delta
	if move_timer <= 0:
		move_timer = 0.5
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
	if not start:
		return

	# salva a posição atual da cabeça
	var last_position = position
	position += direction * cell_size

	# movimenta cada parte do corpo
	for i in range(body_parts.size()):
		var temp = body_parts[i].position
		body_parts[i].position = last_position
		last_position = temp

	# adiciona novos segmentos se tiver pendente
	if pending_growth > 0:
		var new_segment = segment_scene.instantiate()
		new_segment.position = last_position
		get_parent().add_child(new_segment)
		body_parts.append(new_segment)
		pending_growth -= 1

func grow(amount: int = 1) -> void:
	# chama essa função quando comer uma maçã, por exemplo
	pending_growth += amount

func Die():
	get_tree().change_scene_to_file("res://scenes/game/game_over.tscn")

func pause():
	Pause.visible = true
