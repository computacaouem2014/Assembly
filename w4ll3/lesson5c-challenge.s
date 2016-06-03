.section .data

n:	.int	0
n1:	.int	0
n2:	.int	0
p1:	.asciz	"Digite quantos numeros deseja comparar >> "
p2:	.asciz	"N1: "
p3:	.asciz	"N2: "
f:	.asciz	"%d"
r1:	.asciz	"Loop %d. n1 maior que n2\n"
r2:	.asciz	"Loop %d. n2 maior que n1\n"
r3:	.asciz	"Loop %d. n1 igual a n2\n"

.section .text
.globl _start

_start:
	pushl	$p1
	call	printf
	addl	$4, %esp

	pushl	$n
	pushl	$f
	call	scanf
	addl	$8, %esp
	movl	n, %ecx

_loopy:
	movl	%ecx, %ebx
	push	$p2
	call	printf
	addl	$4, %esp
	
	push	$n1
	push	$f
	call	scanf
	addl	$8, %esp

	push	$p3
	call	printf
	addl	$4, %esp
	
	push	$n2
	push	$f
	call	scanf
	addl	$8, %esp

	jmp	comp

back:
	movl	%ebx, %ecx
	loop	_loopy
	jmp	exit

comp:
	movl	n2, %eax
	cmpl	n1, %eax
	je	equals
	jl	n2bign1
	jmp	n1bign2

equals:
	push	%ebx
	push	$r3
	call	printf
	addl	$8, %esp
	jmp	back
	
n2bign1:
	push	%ebx
	push	$r1
	call	printf
	addl	$8, %esp
	jmp	back

n1bign2:
	push	%ebx
	push	$r2
	call	printf
	addl	$8, %esp
	jmp	back

exit:
	push	$0
	call	exit
