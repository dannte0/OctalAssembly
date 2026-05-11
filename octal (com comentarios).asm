.data
	msgEntrada:.asciiz"Digite um numero octal (8): "
	saida1:.asciiz"\n O numero "
	saida2:.asciiz" é octal.\n"
	saidaFalso:.asciiz" não"
	#Tratamentos de erros
	#Se numero digitado for = 0
	paraZero:.asciiz"Numero não pode ser igual a zero.\nDigite novamente: "
	paraMenorZero:.asciiz"Numero não pode ser menor que zero.\nDigite novamente: "
.text
main:
	#Digite um numero octal (8):
	li $v0, 4
	la $a0, msgEntrada
	syscall
	li $v0, 5
	syscall
	add $t0, $v0, $zero
	#se $t0 == 0
	beqz $t0, seZero
	#se $t0 < 0
	bltz $t0, seMenorZero
	#senão
	j seMaiorZero
	
seZero: 
	#Numero não pode ser igual a zero. Digite novamente: "
	li $v0, 4
	la $a0, paraZero
	syscall
	li $v0, 5
	syscall
	add $t0, $v0, $zero
	#se $t0 == 0
	beqz $t0, seZero
	#se $t0 < 0
	bltz $t0, seMenorZero
	#senão
	j seMaiorZero
	
seMenorZero:
	#"Numero não pode ser menor que zero.\nDigite novamente: "
	li $v0, 4
	la $a0, paraMenorZero
	syscall
	li $v0, 5
	syscall
	add $t0, $v0, $zero
	#se $t0 == 0
	beqz $t0, seZero
	#se $t0 < 0
	bltz $t0, seMenorZero
	#senão
	j seMaiorZero
	
seMaiorZero:
	#copia input
	add $t8, $t0, $zero
	#Etapa para descobrir a quantidade de casas
	enquantoNaoZero:
	#Divisao por 10 para descobrir a quantidade de vezes que se pode dividir o numero
	div $t8, $t8, 10
	#Contador = $t4 (recebe a quantidade de casas)
	add $t4, $t4, 1
	#Se $t8 nõo for zero ainda é divisivel
	bnez $t8, enquantoNaoZero
	#Retorna o valor
	add $t8, $t0, $zero
		
	#$t7 vira o divisor 10
	add $t7, $t7, 10
	
	#Etapa para verificar cada digito
	verifica:
	#Obtem ultimo digito do numero
	rem $t6, $t8, $t7
	#Obtem os digitos a esquerda do numero
	div $t8, $t8, $t7
	#Verifica se o ultimo digito é maior que 7, se verdadeiro numero não pode ser octal
	bgt $t6, 7, naoOctal
	#Contador = $t5 (percorre a quantidade de casas)
	add $t5, $t5, 1
	#Verifica se o numero de casas já percorridas é igual ao de encontradas 
	blt $t5, $t4, verifica
	
	#Verifica se o digito que sobrou é maior que 7
	bgt $t8, 7, naoOctal

octal:
	#O numero ... é octal.
	li $v0, 4
	la $a0, saida1
	syscall
	li $v0, 1
	add $a0, $t0, $zero
	syscall
	li $v0, 4
	la $a0, saida2
	syscall
	j fim
		
naoOctal:
	#O numero ... não é octal.
	li $v0, 4
	la $a0, saida1
	syscall
	li $v0, 1
	add $a0, $t0, $zero
	syscall
	li $v0, 4
	la $a0, saidaFalso
	syscall
	li $v0, 4
	la $a0, saida2
	syscall
fim:
