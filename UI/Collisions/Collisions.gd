extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_collision_l_body_entered(body: Node2D) -> void:
	if body.is_in_group("snake"):
		body.Die()
	pass # Replace with function body.
	
func _on_collision_r_body_entered(body: Node2D) -> void:
	if body.is_in_group("snake"):
		body.Die()

func _on_collision_b_body_entered(body: Node2D) -> void:
	if body.is_in_group("snake"):
		body.Die()

func _on_collison_t_body_entered(body: Node2D) -> void:
	if body.is_in_group("snake"):
		body.Die()
