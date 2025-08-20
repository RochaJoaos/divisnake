extends Node2D

@export var qtd:int = 4
@export var min_val:int = 1
@export var max_val:int = 100
@export var margem:int = 40

var valores: Array[int] = []

#func _ready() -> void:
#	gerar()

func limpar() -> void:
	for c in get_children():
		c.queue_free()
	valores.clear()

func gerar() -> void:
	limpar()
	var tela := get_viewport_rect().size
	for i in qtd:
		var v := randi_range(min_val, max_val)
		valores.append(v)

		var lbl := Label.new()
		lbl.text = str(v)
		lbl.add_theme_font_size_override("font_size", 22)
		lbl.position = Vector2(
			randf_range(margem, tela.x - margem),
			randf_range(margem, tela.y - margem)
		)
		add_child(lbl)

func get_valores() -> Array[int]:
	return valores.duplicate()
