extends Node2D

signal numero_clicado(valor:int)

@export var qtd:int = 5 # determina a quatidade para os numeros em tela
@export var min_val:int = 1  # valor minimo de numeros (para os errados)
@export var max_val:int = 99 # maximo de numeros (para os errados)
@export var margem:int = 40  # bota uma margem pra longe das bordas
@export var proporcao_corretos: float = 0.2       # 2% corretos ou seja de 5 numeros, 1 são certos

var valores: Array[int] = []   # números exibidos atualmente

func limpar() -> void:
	for c in get_children(): #pega os nós filhos
		c.queue_free() 		 # limpa da tela
	valores.clear()			 # limpa da lista do "valores"

# gera números com base no pivô
func gerar(pivo:int) -> void:
	limpar() # sempre chama o limpar antes de gerar novos numeros

	var tela := get_viewport_rect().size # pega o tamanho da tela 
	var corretos := _divisores_de(pivo) # coloca os n° corretos na variavel corretos

	if corretos.is_empty(): 
		push_warning("Nenhum divisor encontrado para o pivô") # caso nao tenha divisor(numero primo)
		return

	#decide quantos corretos vao aparecer na tela
	var corretos_na_tela: int = int(round(qtd * proporcao_corretos)) # qtd * proporção = 2
	corretos.shuffle() # embaralha a lista de corretos
	
	# os numeros corretos esolhidos pega os dois primeiros da lista depois de embaralhados
	var escolhidos_corretos := corretos.slice(0, min(corretos_na_tela, corretos.size())) 

	# define que os numeros errados sempre estao menor que o pivo e maior ou igual a 2 
	var min_possiveis_numeros:int = 2
	var max_possiveis_numeros:int = pivo - 1

	# junta corretos + errados
	var opcoes: Array[int] = [] # primeiro cria a lista vazia
	opcoes.append_array(escolhidos_corretos) # 1° coloca todos os valores do escolhidos_corretos dentro de opções

	while opcoes.size() < qtd: # enquanto opçoes que por enquanto tem 2 valores, ainda for menor que qtd (6):
		var possiveis_numeros := randi_range(min_possiveis_numeros, max_possiveis_numeros) # sorteia um numero
		if possiveis_numeros in opcoes: # se o numero sorteado ja estiver em opções:
			continue # ignora
		if pivo % possiveis_numeros != 0:   # garante que nao seja numero correto
			opcoes.append(possiveis_numeros) # adiciona em opções

	opcoes.shuffle() # embaralha opções
	valores = opcoes.duplicate() # aqui salva as opções na variavel valores

	# cria as labels e deixa clicáveis para o teste
	for v in opcoes: #pra cada valor em opcoes:
		var lbl := Label.new() #nova label
		lbl.text = str(v) # texto da label é o 'valor'
		lbl.add_theme_font_size_override("font_size", 22) # tamanho da fonte
		# vai colocar o texto respeitando o tamanho da tela e margem
		lbl.position = Vector2(
			randf_range(margem, tela.x - margem),
			randf_range(margem, tela.y - margem)
		)

		lbl.mouse_filter = Control.MOUSE_FILTER_STOP # pro mouse reconhecer o label
		lbl.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND # cursor muda pra mãozinha
		# quando o label é clicado com o mouse, emite o sinal numero_clicado junto com o valor dele.
		lbl.gui_input.connect(func(event: InputEvent) -> void: 
	#se o evento é um clique do mouse e quando acaba de ser clicado e se foi o botao esquerdo do mouse:
			if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				numero_clicado.emit(v) # emite o sinal com o valor 'v'
		)

		add_child(lbl) # adiciona esse label como nó filho do node2d

# retorna os valores atuais na tela 
func get_valores() -> Array[int]:
	return valores.duplicate()

# calcula divisores
func _divisores_de(pivo:int) -> Array[int]:
	var ds: Array[int] = [] # define a variavel ds uma lista ainda vazia 
	#para d em 2 ate o numero do pivo: faz a logica de divisao e adiciona na lista
	for d in range(2, pivo): # se quiser incluir o pivo tbm: pivo + 1
		if pivo % d == 0: # logica de divisao
			ds.append(d) #adiciona na lista

	return ds # retorna a lista de todos os divisores desse pivo.
