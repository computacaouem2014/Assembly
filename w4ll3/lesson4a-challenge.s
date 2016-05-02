#definicao de variaveis
.section .data
  saida: .asciz "Soma: %d + %d + %d = %d - %d = %d\n"
  n1: .int 10
  n2: .int 25
  n3: .int 5
  n4: .int 40
  v1: .int 10, 25, 5, 40
  
#secao temporaria de 4bytes
.section .bss
.lcomm res1, 4
.lcomm res, 4
.section .text
.globl _start
_start:

 #calcula n1 + n2 + n3 e coloca em res1 e res1 - n4 em res
  movl n3, %eax
  addl n2, %eax
  addl n1, %eax
  movl %eax, res1
  subl n4, %eax
  movl %eax, res
  
 #empilha n1, n2, n3, resultado da soma, n4, resultado da subtracao e string de saida e chama printf
  pushl res
  pushl n4
  pushl res1
  pushl n3
  pushl n2
  pushl n1
  pushl $saida
  call printf
  
#desempilha 28bytes (4bytes de cada push)
  addl $28, %esp
  
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
  movl %eax, res1
  
#faz a subtracao
  subl n4, %eax
  
#copia o resultado final em res
  movl %eax, res
  
 #empilha n1, n2, n3, resultado da soma, n4, resultado da subtracao e string de saida e chama printf
  pushl res
  pushl n4
  pushl res1
  pushl n3
  pushl n2
  pushl n1
  pushl $saida
  call printf
  
#saida
  pushl $0
  call exit
