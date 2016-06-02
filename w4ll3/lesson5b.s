.section .data
	saida:	.asciz	"Teste %d: Resultado = %X\n\n"
	saida2:	.asciz	"Teste %d: Quociente = %X e Resto = %X\n\n"
	saida3:	.asciz	"Teste %d: Resultado = %X:%X\n\n"

.section .text
.globl _start

_start:

_sumreg32b:
	movl	$0x12340000, %eax
	movl	$0x00005678, %ebx
	addl	%ebx, %eax
	pushl	%eax
	pushl	$1
	pushl	$saida
	call	printf
	addl	$12, %esp

_sumreg16b:
	movl	$0x10000000, %eax
	movl	$0x00005678, %ebx
	addw	%bx, %ax
	pushl	%eax
	pushl	$2
	pushl	$saida
	call printf
	addl	$12, %esp

_sumreg8b:
	movl	$0x10000000, %eax
	movl	$0x00005678, %ebx
	movb	%bl, %al
	pushl	%eax
	pushl	$3
	pushl	$saida
	call	printf
	addl	$12, %esp

_subreg32b:
	movl	$0x12345678, %eax
	movl	$0x02045608, %ebx
	subl	%ebx, %eax
	pushl	%eax
	pushl	$4
	pushl	$saida
	call	printf
	addl	$12, %esp

_subreg16b:
	movl	$0x12345678, %eax
	movl	$0x12345678, %ebx
	subw	%bx, %ax
	pushl	%eax
	pushl	$5
	pushl	$saida
	call	printf
	addl	$12, %esp

_subreg8b:
	movl	$0x12345678, %eax
	movl	$0x12345678, %ebx
	subb	%bl, %al
	pushl	%eax
	pushl	$6
	pushl	$saida
	call	printf
	addl	$12, %esp

_increg:
	movl	$0xC, %eax
	incl	%eax		#increases 32bits register by 1
	incw	%ax		#increases 16bits register by 1
	incb	%al		#increases 8bits register by 1
	pushl	%eax
	pushl	$7
	pushl	$saida
	call	printf
	addl	$12, %esp

_decreg:
	movl	$0xF, %eax
	decl	%eax		#decreases 32bits register by 1
	decw	%ax		#decreases 16bits register by 1
	decb	%al		#decreases 8bits register by 1
	pushl	%eax
	pushl	$8
	pushl	$saida
	call	printf
	addl	$12, %esp

_div64to32:
	movl	$0, %edx
	movl	$0x24682467, %eax
	movl	$2, %ebx
	divl	%ebx		#divides %eax by %ebx and moves the\
	pushl	%edx		#rest to edx
	pushl	%eax
	pushl	$9
	pushl	$saida2
	call	printf
	addl	$16, %esp
	
_bigt64to32: #same as _div64to32, but divs biggers than 64bits
	movl	$0x00002468, %edx
	movl	$0x00001234, %eax
	movl	$0x24680, %ebx
	div	%ebx
	pushl	%edx
	pushl	%eax
	pushl	$10
	pushl	$saida
	call	printf
	addl	$16, %esp

_div32to16:
	movl	$0, %eax
	movl	$0, %edx
	movw	$0x8817, %ax
	movw	$0x8800, %bx
	divw	%bx		#divs using 16bits registers
	pushl	%edx
	pushl	%eax
	pushl	$11
	pushl	$saida
	call	printf
	addl	$16, %esp

_bigt32to16:
	movl	$0, %eax
	movl	$0x1, %edx
	movl	$0xFF17, %ax
	movl	$0xFF00, %bx
	divw	%bx
	pushl	%edx
	pushl	%eax
	pushl	$12
	pushl	$saida
	call 	printf
	addl	$16, %esp

_div16to8:
	movl	$0, %eax
	movl	$0, %edx
	movw	$0x01F7, %ax
	movb	$0xF0, %bl
	divb	%bl
	movl	%eax, %edx
	sarw	$8, %dx
	pushl	%edx
	andw	$0x00FF, %ax
	pushl	%eax
	pushl	$13
	pushl	$saida2
	call	printf
	addl	$12, %esp

pushl	$0
call	exit

