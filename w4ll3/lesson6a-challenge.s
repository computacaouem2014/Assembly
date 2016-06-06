.section .data
pergunta:	.asciz	"\n\nExecutar novamente? <1> Sim <2> Nao: "
tchau:		.asciz	"\n\nTchauTchau..."
pede_a:		.asciz	"\na = "
pede_b:		.asciz	"\nb = "
pede_c:		.asciz	"\nc = "
mostra_abc:	.asciz	"\na = %d, b = %d, c = %d"
eq_eq:		.asciz	"\n%d = %d = %d\n"
eq_be:		.asciz	"\n%d = %d > %d\n"
eq_le:		.asciz	"\n%d = %d < %d\n"
le_le:		.asciz	"\n%d < %d < %d\n"
le_eq:		.asciz	"\n%d < %d = %d\n"
le_be:		.asciz	"\n%d < %d > %d\n"
be_be:		.asciz	"\n%d > %d > %D\n"
be_eq:		.asciz	"\n%d > %d = %d\n"
be_le:		.asciz	"\n%d > %d < %d\n"
formato:	.asciz	"%d"

a:		.int	0
b:		.int	0
c:		.int	0
resp:		.int	0

.section .text
.globl	_start
_start:

volta:
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

	pushl	$pede_c
	call	printf

	pushl	$c
	pushl	$formato
	call	scanf

	pushl	c
	pushl	b
	pushl	a
	pushl	$mostra_abc
	call	printf

	addl	$52, %esp

	movl	b, %ebx
	cmpl	a, %ebx

	jz	aigualb
	jg	amenorb
	cmpl	c, %ebx
	jz	abc_be_eq
	jg	abc_be_le
	pushl	c
	pushl	b
	pushl	a
	pushl	$le_le
	call	printf
	jmp	fim

abc_be_eq:
	pushl	c
	pushl	b
	pushl	a
	pushl	$be_eq
	call	printf
	jmp	fim

abc_be_le:
	pushl	c
	pushl	b
	pushl	a
	pushl	$be_le
	call	printf
	jmp	fim

abc_eq_eq:
	pushl	c
	pushl	b
	pushl	a
	pushl	$eq_eq
	call	printf
	jmp	fim

abc_eq_le:
	pushl	c
	pushl	b
	pushl	a
	pushl	$eq_le
	call	printf
	jmp	fim

aigualb:
	cmpl	c, %ebx
	jz	abc_eq_eq
	jg	abc_eq_le
	pushl	c
	pushl	b
	pushl	a
	pushl	$eq_be
	call	printf

abc_le_eq:
	pushl	c
	pushl	b
	pushl	a
	pushl	$le_eq
	call	printf
	jmp	fim
	
abc_le_le:
	pushl	c
	pushl	b
	pushl	a
	pushl	$le_le
	call	printf
	jmp	fim

amenorb:
	cmpl	c, %ebx
	jz	abc_le_le
	je	abc_le_eq
	pushl	c
	pushl	b
	pushl	a
	pushl	$le_be
	call	printf

fim:
	pushl	$pergunta
	call	printf
	
	pushl	$resp
	pushl	$formato
	call	scanf
	movl	resp, %eax

	cmpl	$1, resp
	jz	volta

	pushl	$tchau
	call	printf
	
	pushl	$0
	call	exit
