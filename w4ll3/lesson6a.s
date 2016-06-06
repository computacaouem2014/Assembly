.section .data
pergunta:	.asciz	"\n\nDeseja executar novamente? <1> SIM ou <0> NAO: "
tchau:		.asciz	"\n\nTchau tchau!\n\n"
pede_a:		.asciz	"\nDigite a: "
pede_b:		.asciz	"\nDigite b: "
mostra_a_b:	.asciz	"\na = %d, b = %d\n"
a_igual_b:	.asciz	"\nA = B\n"
a_menor_b:	.asciz	"\nA < B\n"
a_maior_b:	.asciz	"\nA > B\n"
formato:	.asciz	"%d"
pulalin:	.asciz	"\n\n"
	
	
			
a:		.int	0	
b:		.int	1
resp:		.int	0

.section .text

.globl	_start
_start:

volta:
	pushl	$pulalin
	call	printf

	pushl	$pede_a
	call	printf

	pushl	$a
	pushl	$formato
	call	scanf

	pushl	$pede_b
	call	printf

	pushl	$b
	pushl	$formato
	call	scanf
	pushl	b
	pushl	a
	pushl	$mostra_a_b
	call	printf

	addl	$40, %esp

	movl	b, %ebx
	cmpl	a, %ebx
	
	jz	aigualb
	jg	amenorb
	pushl	$a_maior_b
	call	printf
	jmp	fim

aigualb:
	pushl	$a_igual_b
	call	printf
	jmp	fim

amenorb:
	pushl	$a_menor_b
	call	printf

fim:
	push	$pergunta
	call	printf
	pushl	$resp
	
	pushl	$formato
	call	scanf
	movl	resp, %eax
	
	cmpl	$1, resp
	jz	volta

	pushl	$tchau
	call	printf
	addl	$4, %esp

	pushl	$0
	call	exit
