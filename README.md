PIHS
===

Listas de exercícios e exercícios feitos em sala de aula de PIHS. Recomendável resolvê-las por conta própria e usar as soluções daqui apenas para conferir/comparar respostas. 

===

Como usar:
  * Você pode visualizar os arquivos pelo próprio GitHub.
  * Baixar e editar em qualquer editor de texto.
  * Se for fazer alguma edição ou novo arquivo que nao seja pelo próprio site, `git pull` antes de começar para não ter problemas com conflitos e merges.

===

Links:
  * [Code::Blocks](http://www.codeblocks.org/downloads)
  * [DevC++](http://www.bloodshed.net/download.html)
  * [CodeLite](http://downloads.codelite.org/)
  * [Eclipse com Extensão para C/C++](http://www.eclipse.org/downloads/packages/eclipse-ide-cc-developers/lunar)
  * [NetBeans (pacotes com apenas C/C++ ou completo)](https://netbeans.org/downloads/)
  * Visual Studio: [Aqui](http://www.visualstudio.com/downloads/download-visual-studio-vs) ou [aqui](http://thepiratebay.se/)
  * [CLion by JetBrains](http://www.jetbrains.com/clion/)

===

Instruções para compilar (Máquina linux 32bits):
 * as -gstabs nomedoarquivo.s -o nomedoarquivo.o
 * ld nomedoarquivo.o -l c -dynamic-linker /lib/ld-linux.so.2 -o nomedoarquivo (caso use alguma função de biblioteca da linguagem c)
 * ./nomedoarquivo ou gdb nomedoarquivo

===

VIM:
 :command! WR w! | !clear && as -gstabs % -o %:r.o && ld %:r.o -l c -dynamic-linker /lib/ld-linux.so.2 -o %:r && gdb %:r
