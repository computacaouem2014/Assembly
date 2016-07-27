#declaracao das variaveis

.section .data
abertura:	.asciz "\nPrograma para Somar 3 numeros\n"
saida:		.asciz "Soma: %d + %d + %d = %d\n"
peden1:		.asciz "\nEntre com o valor de n1 = "
peden2:		.asciz "\nEntre com o valor de n2 = "
peden3:		.asciz "\nEntre com o valor de n3 = "
formato:	.asciz "%d" #tipo de dado lido pelo scanf

n1:	.int 0
n2:	.int 0
n3:	.int 0
vec:	.int 0, 0, 0
res:	.int 0

.section .text

.globl	main
main:
	#printa abertura
	pushl	$abertura
	call	printf
	addl	$4	,	%esp

	#armazena endereco inicial do vetor
	movl	$vec	,	%eax

	#pede n1
	pushl	$peden1
	call	printf
	addl	$4	,	%esp

	#chama scanf para armazenar o valor
	pushl	%eax
	pushl	$formato
	call	scanf
	addl	$8	,	%esp

	#aumenta o endereco do vetor em 1 posicao
	movl	(%eax)	,	%ebx
	addl	$4	,	%eax

	#pede n1
	pushl	$peden2
	call	printf
	addl	$4	,	%esp

	#chama scanf para armazenar o valor
	pushl	%eax
	pushl	$formato
	call	scanf
	addl	$8	,	%esp

	#aumenta o endereco em mais 1
	addl	(%eax)	,	%ebx
	addl	$4	,	%eax

	#pede n1
	pushl	$peden3
	call	printf
	addl	$4	,	%esp

	#chama scanf para armazenar o valor
	pushl	%eax
	pushl	$formato
	call	scanf
	addl	$8	,	%esp

	#aumenta o endereco
	addl	(%eax)	,	%ebx

	#armazena o valor da soma em res
	movl	%ebx	,	res

	#chama printf com saida final
	pushl	res
	pushl	vec
	pushl	$saida
	call	printf
	addl	$16	,	%esp

	#saida de sistema
	pushl $0
	call exit
