extends CharacterBody2D

var input: Vector2 = Vector2.ZERO
var right: String
var velocidade: float = 200.0

@onready var lado: Sprite2D = $Sprite2D
@onready var Pause: Control = $"../UI_Pause/Pause"

func get_imput():
	if int(Input.is_action_just_released("ui_right")):
		input.y = 0
		input.x = 1
		lado.rotation_degrees = -90
	if int(Input.is_action_just_released("ui_left")):
		input.y = 0
		input.x = -1
		lado.rotation_degrees = 90
	if int(Input.is_action_just_released("ui_up")):
		input.x = 0
		input.y = -1
		lado.rotation_degrees = 180
	if int(Input.is_action_just_released("ui_down")):
		input.x = 0
		input.y = 1
		lado.rotation_degrees = 0
	if int(Input.is_action_just_released("ui_cancel")):
		pause()
	input = input.normalized()
	
func character_movement():
	velocity = input * velocidade
	
func pause():
	input.x = 0
	input.y = 0
	Pause.visible = true

func Die():
	get_tree().change_scene_to_file("res://scenes/game/game_over.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_imput()
	character_movement()
	move_and_slide()
	pass
