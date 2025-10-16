extends CharacterBody2D

@export var direction: Vector2 = Vector2.RIGHT
var cell_size: int = 36
var move_timer: float = 0.5 # tempo entre movimentos (velocidade da cobra)
@export var start : bool = false
@onready var head : Sprite2D = $head
@onready var body := $body
@onready var tail := $tail
@onready var Pause: Control = $"../UI_Pause/Pause"
@export var localsnake := Vector2(2, 4)
var min_screen_x : int = 216
var min_screen_y : int = 36
var max_screen_x : int = 900
var max_screen_y : int = 576

# --- corpo da cobra ---
var body_parts: Array = []  # lista com os pedaços da cobra
var pending_growth: int = 0 # quantos segmentos devem ser adicionados

func _ready():
	position = position.snapped(Vector2(cell_size, cell_size))

func _process(delta):
	get_input()
	move_timer -= delta
	if move_timer <= 0:
		move_timer = 0.3
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
	
	body_parts.insert(0, body.position)
	position += direction * cell_size
	body.position = last_position
	
	#delimita a parede da arena, se ela enconstar perde
	#if position.x > max_screen_x || position.x < min_screen_x || position.y > max_screen_y || position.y < min_screen_y:
	#	get_tree().change_scene_to_file("res://scenes/game/game_over.tscn")
	#	print("Tela")

	print("### POSICAO: ", position)
	print("### OlD    : ", last_position)
	print("### Body   : ", body.position)


func grow(amount: int = 1) -> void:
	# chama essa função quando comer uma maçã, por exemplo
	pending_growth += amount

func Die():
	get_tree().change_scene_to_file("res://scenes/game/game_over.tscn")

func pause():
	Pause.visible = true
