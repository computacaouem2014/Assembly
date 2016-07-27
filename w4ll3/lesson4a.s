#definicao de variaveis
.section .data
  saida: .asciz "Soma: %d + %d + %d = %d\n"
  n1: .int 10
  n2: .int 25
  n3: .int 5
  v1: .int 10, 25, 5

#secao temporaria de 4bytes
.section .bss
.lcomm res, 4
.section .text
.globl _main
_main:

 #calcula n1 + n2 + n3 e coloca em res
  movl n3, %eax
  addl n2, %eax
  addl n1, %eax
  movl %eax, res

 #empilha n1, n2, n3, a string  de saida e chama printf
  pushl res
  pushl n3
  pushl n2
  pushl n1
  pushl $saida
  call printf

#desempilha 20bytes (4bytes de cada registrador)
  addl $20, %esp

#armazena endereço de v1 em %edi
  movl $v1, %edi

#move o valor de %edi para %eax
  movl (%edi), %eax

#aumenta o valor do endereço inicial de %edi em 4bytes (1 registrador de 32bits)
  addl $4, %edi

#adiciona o segundo valor de %edi em %eax
  addl (%edi), %eax


#aumenta o valor do endereço inicial de %edi em 4bytes (1 registrador de 32bits)
  addl $4, %edi
  addl (%edi), %eax

#copia o resultado da soma de v1 (%edi) em res
  movl %eax, res

#empilha n1, n2, n3, a string  de saida e chama printf
  pushl res
  pushl n3
  pushl n2
  pushl n1
  pushl $saida
  call printf

#saida
  pushl $0
  call exit
