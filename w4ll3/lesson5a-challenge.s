.section .data
	m1:	.asciz	"Digite o primeiro numero: "
	m2:	.asciz	"Digite o segundo numero: "
	rx:	.asciz	"O resultado da multiplicacao e %d.\n"
	f:	.asciz	"%d"
	x:	.int	0
	y:	.int	0

.section .text
.globl _main
_main:
	#pega primeiro valor
	pushl	$x
	pushl	$f
	pushl	$m1
	call	printf
	addl	$4, %esp
	call	scanf
	addl	$8, %esp

	#pega segundo valor
	pushl	$y
	pushl	$f
	pushl	$m2
	call	printf
	addl	$4, %esp
	call	scanf
	addl	$8, %esp

	#multiplicar por 8
	movl	x	,	%eax
	salb	$3	,	%eax

	#mostra resultado de entrada * 8
	pushl	%eax
	pushl	$rx
	call	printf
	addl	$8, %esp

	#quebra segundo numero
	movl	y	,	%ebx


	pushl	$0
	call	exit
