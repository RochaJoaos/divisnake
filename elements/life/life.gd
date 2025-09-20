extends Control

@export var your_life : int = 3
@onready var heart01 : Sprite2D = $"1"
@onready var heart02 : Sprite2D = $"2"
@onready var heart03 : Sprite2D = $"3"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	count_heart()
	
func count_heart():
	if your_life == 2:
		heart03.texture = load("res://assets/icons/dead.png")
	elif your_life == 1:
		heart03.texture = load("res://assets/icons/dead.png")
		heart02.texture = load("res://assets/icons/dead.png")
	elif  your_life <= 0:
		heart03.texture = load("res://assets/icons/dead.png")
		heart02.texture = load("res://assets/icons/dead.png")
		heart01.texture = load("res://assets/icons/dead.png")
		get_tree().change_scene_to_file("res://scenes/game/game_over.tscn")
