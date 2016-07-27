.section .data

menu:			.asciz	"\nESCOLHA A OPCAO:\n1 - INSERIR\n2 - REMOVER\n3 - CONSULTAR\n4 - LISTAR\n> "
titemp:			.asciz	"\nEMPILHAMENTO:\n"
titreg:			.asciz	"\nRegistro no %d:"
titdesemp:		.asciz	"\nDESEMPILHAMENTO:\n"
titmostra:		.asciz	"\nELEMENTOS DA PILHA:\n"
pedera:			.asciz	"Digite o ra: "
formach:		.asciz	"%c"
msgerro:		.asciz	"\nOPCAO INCORRETA!\n"
titgeral:		.asciz	"\n*** APLICACAO DE PILHA ***\n\n"
msgvazia:		.asciz	"\nPILHA VAZIA!\n"
msgremov:		.asciz	"\nREGISTRO DESEMPILHADO!\n"
msginser:		.asciz	"\nREGISTRO EMPILHADO!\n"
pedenome:		.asciz	"\nDigite o nome: "
pedesexo:		.asciz	"Qual o sexo, <F>eminino ou <M>asculino?: "
mostrara:		.asciz	"\nRA: %d"
mostrapt:		.asciz	"\nptreg = %d\n"
formastr:		.asciz	"%s"
formanum:		.asciz	"%d"
pulalinha:		.asciz	"\n"
pedecurso:		.asciz	"Digite o nome do curso: "
mostranome:		.asciz	"\nNome: %s"
mostrasexo:		.asciz	"\nSexo: %c"
mostracurso:	.asciz	"\nCurso: %s\n"

nome:			.space 44
dia:			.space 4
mes:			.space 4
ano:			.space 4
sexo:			.space 4
curso:			.space 24

NULL:			.int 0
opcao:			.int 0
naloc:			.int 84
prox:			.int NULL
ptpilha:		.int NULL
ptreg:			.int NULL

/*
Implementar uma estrutura de lista encadeada dinâmica com as funções de insere(), remove(), consulta(), atualiza() e lista(). As funções devem ser implementadas com call/ret. A alocação da lista deve ser dinâmica e os elementos devem ser inseridos ordenadamente pelo nome. As funções de consulta, remoção e atualização também devem utilizar o nome como chave de busca, o qual deverá ser obtido do usuário. Os registros armazenados devem conter nome (string), data de nascimento (3 inteiros) sexo (caractere) profissão (string) salario (float) Deverá ser implementado também um módulo principal que faz uso das funções, fornecendo para o usuário um menu de opções. O usuário deverá digitar as informações do registro a ser inserido. O trabalho deve ser feito em grupos de 2 participantes. O trabalho deve se basear nas instruções usadas nas aulas.
*/

.section .text
.globl _main

_main:
	jmp imain

le_dados:

#armazena em %edi o nome
	pushl	%edi
	call	_gets

#pushl	-80(%edi)
#call 	strcmp

#avança %edi em 44bytes
	popl	%edi
	addl	$44, %edi
	pushl	%edi

#armazena em %edi o RA
	pushl	$formanum
	call	_scanf
	call	_getchar

#avança %edi em 8bytes
	popl	%edi
	addl	$8, %edi
	pushl	%edi

#armazena em %edi o sexo
	pushl	$formach
	call	_scanf
	call	_getchar

#avança %edi em 4bytes
	popl	%edi
	addl	$4, %edi
	pushl	%edi

#armazena em %edi o curso
	call	_gets

#avança %edi em 24bytes e retorna para posição inicial
	popl	%edi
	addl	$24, %edi
	movl	$NULL, (%edi)
	subl	$80, %edi

	RET

mostra_dados:

#empilha %edi e printa
	pushl	%edi
	pushl	$mostranome
	call	_printf
	addl	$8, %esp

#avança para prox registro
	addl	$44, %edi
	pushl	%edi
	pushl	(%edi)

#printa proximo registro
	pushl	$mostrara
	call	_printf
	addl	$8, %esp
	popl	%edi

#avança para prox registro
	addl	$8, %edi
	pushl	%edi
	pushl	(%edi)

#printa proximo registro
	pushl	$mostrasexo
	call	_printf
	addl	$8, %esp

#avança para prox registro
	popl	%edi
	addl	$4, %edi
	pushl	%edi

#mostra proximo registro
	pushl	$mostracurso
	call	_printf
	addl	$4, %esp

#retorna posição original
	popl	%edi
	subl	$56,%edi

	RET

empilha:

#aloca memoria
	movl	naloc, %ecx
	pushl	%ecx
	call	_malloc

#
	movl	%eax, ptreg
	movl	ptreg, %edi

#pede dados
	call	le_dados
	movl	ptpilha, %eax
	movl	%eax, 80(%edi)
	movl	%edi, ptpilha
	pushl	$msginser
	call	_printf
	addl	$4, %esp
	jmp		menuop

desempilha:
	pushl	$titdesemp
	call	_printf
	addl	$4, %esp
	movl	ptpilha, %edi
	cmpl	$NULL, %edi
	jnz		continua
	pushl	$msgvazia
	call	_printf
	addl	$4, %esp
	jmp		menuop

continua:
	movl	ptpilha, %edi
	pushl	%edi
	movl	80(%edi), %edi
	movl	%edi, ptpilha
	pushl	$msgremov
	call	_printf
	addl	$4, %esp
	call	_free
	addl	$4, %esp
	jmp		menuop

mostrapilha:
	pushl	$titmostra
	call	_printf
	movl	ptpilha, %edi
	cmpl	$NULL, %edi
	jnz		continua2
	pushl	$msgvazia
	call	_printf
	addl	$4, %esp
	jmp		menuop

continua2:
	movl	ptpilha, %edi
	movl	$1, %ecx

volta:
	cmpl	$NULL, %edi
	jz		menuop
	pushl	%edi
	pushl	%ecx
	pushl	$titreg
	call	_printf
	addl	$4, %esp
	movl	4(%esp), %edi
	call	mostra_dados
	popl	%ecx
	incl	%ecx
	popl	%edi
	movl	80(%edi), %edi
	jmp		volta
	jmp		menuop

listar:

RET

imain:
	call	menuop
	cmpl	$1, opcao
	jz		empilha

	cmpl	$2, opcao
	jz		desempilha

	cmpl	$3, opcao
	jz		mostrapilha

	cmpl	$4, opcao
	jz		listar

menuop:
#mostra menu e pega opcao
	pushl	$menu
	call	_printf
	pushl	$opcao
	pushl	$formanum
	call	_scanf
	addl	$12, %esp
	call	_getchar

RET

fim:
	pushl	$0
	call	_exit
