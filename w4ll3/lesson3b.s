.section .data
	output: .asciz "O ID do fabricante eh '%s'\n"

.section .bss
.lcomm fabri, 16

.section .text
.globl _main

_main:
	movl $0, %eax
	cpuid

	movl $fabri, %edi
	movl %ebx, 0(%edi)
	movl %edx, 4(%edi)
	movl %ecx, 8(%edi)

	pushl $fabri
	pushl $output
	call printf
	popl %eax
	popl %eax

	pushl $0
	call exit
