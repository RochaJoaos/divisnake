extends Node

@export var snake_scene : PackedScene

var score : int
var game_started : bool = false

var cells : int = 20
var cell_size : int = 36

var old_data : Array
var snake_data : Array
var snake : Array

var start_pos = Vector2(9, 9)
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var left = Vector2(-1, 0)
var  right = Vector2(1, 0)
var move_direction : Vector2
var can_move : bool  



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
	
func new_game():
	score = 0
	$score.get_node("Label").text = str(score)
	move_direction = up
	can_move = true
	generate_snake()

func generate_snake():
	old_data.clear()
	snake_data.clear()
	snake.clear()
	
	for i in range(3):
		add_segment(start_pos + Vector2(0, i))
		
func  add_segment(pos):
	snake_data.append(pos)
	var SnakeSegment = snake_scene.instantiate()
	SnakeSegment.position = (pos * cell_size) + Vector2(0, cell_size)
	add_child(SnakeSegment)
	snake.append(SnakeSegment)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	snake_move()
	
func snake_move():
	if can_move:
		if Input.is_action_just_pressed("down_move") and move_direction != up:
			move_direction = down
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("left_move") and move_direction != right:
			move_direction = left
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("up_move") and move_direction != down:
			move_direction = up
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("right_move") and move_direction != left:
			move_direction = right
			can_move = false
			if not game_started:
				start_game()
		

func start_game():
	game_started = true
	$moveTimer.start()
		


func _on_move_timer_timeout() -> void:
	can_move = true
	old_data = [] + snake_data
	snake_data[0] += move_direction
	for i in range(len(snake_data)):
		if i > 0:
			snake_data = old_data[i - 1]
		snake[i].position = (snake_data[i] * cell_size) + Vector2(0, cell_size)
