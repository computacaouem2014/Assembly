.section .data

#output: .ascii "O ID do fabricante eh '123456789102'\n"
output: .ascii "O fabricante 'xxxxxxxxxxxx' foi identificado\n"

.section .text

.globl _start

_start:
	movl $0, %eax
	cpuid
_ponto1:
	movl $output, %edi
	movl %ebx, 14(%edi)
	movl %edx, 18(%edi)
	movl %ecx, 22(%edi)
_ponto2:
	movl $4, %eax
	movl $1, %ebx
	movl $output, %ecx
	movl $45, %edx
_ponto3:
	int $0x80
_ponto4:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
