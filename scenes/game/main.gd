extends Node2D

@export var pivo_min:int = 10 # valor mínimo do pivô
@export var pivo_max:int = 99 # valor máximo do pivô

@onready var numeros :=  $Numeros         # referência para o node "numbers" (script dos números em tela)
@onready var cronometro := $Cronometro # referência para o cronômetro
@onready var pivo: Label = $Label_pivo    # referencia para a label que mostra o valor do pivô
@onready var resultado_label: Label = $Label_resultado # referência para a label que mostra "Correto" ou "Errado"
@onready var score_script := $score
@onready var snake := $snake
@onready var life := $life

var pivo_atual: int = 0      # guarda o valor do pivô sorteado atualmente
var jogo_iniciado := false   # pra saber se o jogo já começou

func _ready() -> void:
	randomize() # embaralha o gerador de números aleatórios pra evitar repetições 
	numeros.limpar() # limpa qualquer número que esteja na tela (pegando a função do scrript do numeros)
	if is_instance_valid(pivo): # se o label do pivô existe
		pivo.text = "00" 

func _on_button_pressed() -> void: # quando o botao de começar é clicado
	if jogo_iniciado: return # se ja começou sai
	jogo_iniciado = true # se nn o jogo_iniciado é dado como verdadeiro
	snake.start = jogo_iniciado # se o jogo iniciar a cobra começa a se mover
	
	cronometro.start() # start é a função no script do cronometro que diz pra começar o cronometro
	_sortear_pivo() # chama a função para sortear o pivo
	numeros.gerar(pivo_atual) # chama o gerar do numeros com o pivo q foi sorteado antes
	_atualizar_pivo_ui() # chama a função pra atualizar o texto e label do pivo.

	$Button.disabled = true # desabilita o botao de começar pra nn poder mais clicar
	$Button.visible  = false # deixa invisivel 

#sinal do numbers, sempre quando clicado ele chama 'on_numero_comido(valor)'
func _on_numeros_numero_clicado(valor: int) -> void: 
	on_numero_comido(valor)


func on_numero_comido(valor:int) -> void:
	if not jogo_iniciado: return # se nn começou o jogo entao sai

	#Checa se é correto ou errado e mostra no label
	var acertou := _e_divisor(valor, pivo_atual)
	if score_script:
		score_script.resultado(acertou) 
	if is_instance_valid(resultado_label):
		if acertou:
			resultado_label.text = "Correto!"
			resultado_label.modulate = Color(0, 1, 0)   # muda a cor pra verde
		else:
			life.your_life -= 1

	# agora troca o pivô e renova os números 
	_sortear_pivo() #sorteia o pivo
	numeros.gerar(pivo_atual) # gera os numeros aleatórios de novo
	_atualizar_pivo_ui() # atualiza o texto do label do pivo


func _sortear_pivo() -> void:
	var tentativas := 0 # um contador de tentativas
	while true: # enquanto for verdadeiro:
		var n := randi_range(pivo_min, pivo_max) #sorteia um numero entre o intervalo definido no topo
		if n > 3 and not _num_primo(n):   # garante maior ou igual a 4 e que nao seja primo
			pivo_atual = n # se entrar entao é valido, e entao o pivo é guardado e sai do while.
			break 
		tentativas += 1 # contando as tentativas sse nao passou do if acima
		if tentativas > 100:    # se por acaso passar de 100 tentativas :
			pivo_atual = 4      # o pivo entao vira 4 como plano b
			break

func _num_primo(n:int) -> bool: # funcao q retorna true se o 'n' for primo
	if n <= 1: return false # 0 e 1 nao sao primos 
	if n <= 3: return true # 2 e 3 sao primos
	if n % 2 == 0 or n % 3 == 0: return false # se sao multiplos de 2 e 3 retorna false
	var i := 5 # comeca a testar os divisores a partir do 5

	while i * i <= n: #uma logica louca pra ver se é primo ou nao
		if n % i == 0 or n % (i + 2) == 0:
			return false
		i += 6
	return true

func _atualizar_pivo_ui() -> void: # atualiza o label do pivo com o numero novo 
	if is_instance_valid(pivo):
		pivo.text = "%d" % pivo_atual

func _e_divisor(valor:int, pivo:int) -> bool: #retorna true se o valor é divisor do pivo
	return valor != 0 and pivo % valor == 0  #garante que nao seja zero e ve se é divisor
