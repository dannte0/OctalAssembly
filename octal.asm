.data
	msgEntrada:.asciiz"Digite um numero octal (8): "
	saida1:.asciiz"\n O número "
	saida2:.asciiz" é octal.\n"
	saidaFalso:.asciiz" não"
	paraZero:.asciiz"Numero não pode ser igual a zero.\nDigite novamente: "

.text
main:
	li $v0, 4
	la $a0, msgEntrada
	syscall
	li $v0, 5
	syscall
	add $t0, $v0, $zero
	beqz $t0, seZero
	j senaoZero
	
seZero: 
	li $v0, 4
	la $a0, paraZero
	syscall
	li $v0, 5
	syscall
	add $t0, $v0, $zero
	beqz $t0, seZero
	
senaoZero:
	add $t8, $t0, $zero
	enquantoNaoZero:
	div $t8, $t8, 10
	add $t4, $t4, 1
	bnez $t8, enquantoNaoZero
	add $t8, $t0, $zero
	add $t7, $t7, 10
	
	verifica:
	rem $t6, $t8, $t7
	div $t8, $t8, $t7
	bgt $t6, 7, naoOctal
	add $t5, $t5, 1
	blt $t5, $t4, verifica
	bgt $t8, 7, naoOctal

octal:
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
