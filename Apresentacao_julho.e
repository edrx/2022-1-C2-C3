# This file:
#   http://angg.twu.net/2022-1-C2-C3/Apresentacao_julho.e.html
#   http://angg.twu.net/2022-1-C2-C3/Apresentacao_julho.e
#           (find-angg "2022-1-C2-C3/Apresentacao_julho.e")
# Author: Eduardo Ochs <eduardoochs@gmail.com>
#
# (defun a () (interactive) (find-angg "2022-1-C2-C3/Apresentacao_julho.e"))
# (defun b () (interactive) (find-TH "2022-apresentacao-sobre-C2"))

  (find-fline "~/TH/2019.2-C2.blogme")
  (find-angg ".emacs" "c2q192")
  (c2m221ac2a "title")




Cálculo 2 antes da pandemia
===========================
  Programa do curso:       (find-es "puro" "ementa-e-programa-C2")
    itens que faltaram:    (find-es "puro" "ementa-e-programa-C2" "recorrência")
                           (find-es "puro" "ementa-e-programa-C2" "EDOs homogêneas")

  Provas e material extra: (find-pdf-page "~/LATEX/2019-2-C2-tudo.pdf")
                           (find-pdf-page "~/LATEX/2019-2-C2-tudo.pdf")

  Cronograma do meu curso: (find-TH "2019.2-C2" "programa")
  Índice dos quadros:      (find-angg ".emacs" "c2q192")
    assuntos atípicos:     (find-angg ".emacs" "c2q192" "exatas")

    Ids trigs:             (find-hernandezpage (+ 10 47)
                              "6 Integrais de Funções Trigonométricas")
                           (c2m192tudop 12 "integrate(sen(5*x)^2 * cos(5*x)^2)")
                           (find-es "maxima" "trig-ids")

    Casos particulares:    (find-angg ".emacs" "c2q192" "[:=]")
    Fator integrante:      (find-angg ".emacs" "c2q192" "Trench")
                           (find-books "__analysis/__analysis.el" "trench")
                           (find-trenchpage (+ 10  83) "2.6 Integrating Factors")

Variáveis
=========
  (find-es "maxima" "op-and-args" "action = 'op")

Regra da Cadeia
===============
  (c2m221introp 4 "exercicio-2" "[RC]")
  (c2m221introa   "exercicio-2")
  (c2m221introp 5 "exercicio-3" "Miranda / encontrar a substituição certa")
  (c2m221introa   "exercicio-3")
  (find-dmirandacalcpage 87 "3.5 A Regra da Cadeia")
  (find-dmirandacalcpage 89 "Exerc" "cios")
  (c2m221introp 19 "julho" "Figuras novas (julho)")
  (c2m221introa    "julho")
  (find-pdf-page "~/2022.1-C3/C3-quadros.pdf" 23)

Variáveis dependentes
=====================

  Cálculo 3 funciona melhor se a gente apresenta tanto a
  "notação de físicos" quanto a "notação de matemáticos" e
  vê como traduzir entre as duas... Detalhes aqui:
    (find-pdf-page "~/LATEX/2022-1-C3-notacao-de-fisicos.pdf")

  Quase tudo de Cálculo 2 pode ser feito só com "notação de
  matemáticos", mas eu aviso que a gente vai ver "notação de
  físicos" em Cálculo 3 e dou o link acima pra quem quiser
  olhar por curiosidade.

  "Depois da faculdade vocês provavelmente vão resolver quase todas as
   integrais de vocês usando programas de computação simbólica, e
   esses programas tratam expressões como árvores e variáveis como
   símbolos que vão ser substituídos"...

   ^ Assim que o ensino passou a ser online eu passei a avisar isso no
     início do curso de Cálculo 2.


Subtituição [:=]
================
  Introdução:              (c2m212introp 8 "substituicao")
                           (c2m212introa   "substituicao")
    Defs complicadas:      (c2m212introp 9 "substituicao-2")
                           (c2m212introa   "substituicao-2")
    Exercício 1 ([S2I]):   (c2m212introp 10 "exercicio-1")
                           (c2m212introa    "exercicio-1")
    Somatórios:            (c2m212introp 13 "somatorios-exercs")
                           (c2m212introa    "somatorios-exercs")
    Quantificadores:       (c2m212somas2p 14 "para-todo-e-existe")
                           (c2m212somas2a    "para-todo-e-existe")
    Chutar e testar:       (c2m212introp 12 "EDOs-chutar-testar")
                           (c2m212introa    "EDOs-chutar-testar")

    "=" depois de [:=]:    (c2m212introp 8 "substituicao")
                           (c2m212introa   "substituicao")
    Aviso no quadro:       (find-pdf-page "~/2022.1-C2/C2-quadros.pdf" 1)
			   
    Ferramentas didáticas
    ---------------------
    Gramáticas:            (c2m212introp 4 "contexo")
                           (c2m212introa   "contexo")
                           (c2m212introp 5 "sintaxe")
                           (c2m212introa   "sintaxe")
                           (c2m212introp 6 "sintaxe-2")
                           (c2m212introa   "sintaxe-2")
                           (c2m212introp 7 "linguagem")
                           (c2m212introa   "linguagem")
    Árvores:               (c2m221introp 11 "exercicio-8-intro")
                           (c2m221introa    "exercicio-8-intro")
    Underbraces (jul22):   (c2m221introp 19 "julho")
                           (c2m221introa    "julho")

    (find-fline "~/TH/2021aulas-por-telegram.blogme" "2. Tipos")
    (find-LATEXgrep "grep --color=auto -nH --null -e Tipos 2021-2*.tex")
    (find-LATEXgrep "grep --color=auto -nH --null -e esperto 2021-2*.tex")

Somas de Riemann
================
  Wikipedia:               (c2m212somas1p 15 "exercicio-9")
                           (c2m212somas1a    "exercicio-9")
                           (find-20212C2C1page 47 "decifre")
                           (find-20212C2C1text 47 "decifre")

O jeito esperto
===============
  (c2m212somas1p 7 "jeito-esperto")
  (c2m212somas1a   "jeito-esperto")
  (c2m212somas1p 21 "exercicio-12")
  (c2m212somas1a    "exercicio-12")
  (c2m221somas3p 4 "exercicio-1")
  (c2m221somas3a   "exercicio-1")
   (c2m221somas3p 3 "mountains")
   (c2m221somas3a   "mountains")


Funções escada
==============
  (c2m221mt1p 4 "gabarito")
  (c2m221mt1a   "gabarito")


expr3=expr4 <just>
==================
  Thomas e caso geral:     (c2m212introp 7 "linguagem")
                           (c2m212introa   "linguagem")
  expr [S1]:               (c2m221introp 9 "exercicio-6")
                           (c2m221introa   "exercicio-6")
  Demonstração complicada: (c2m221dfip 4 "demonstracao-complicada")
                           (c2m221dfia   "demonstracao-complicada")
    Outro jogo:            (c2m221dfip 4 "o-jogo")
                           (c2m221dfia   "o-jogo")

Traduções pra Prog 1
====================
  (c2m212introp 5 "sintaxe")
  (c2m212introa   "sintaxe")
  (c2m212isp 5 "set-compr-traducao")
  (c2m212isa   "set-compr-traducao")
  (c2m212isp 6 "fa-e-ex-traducao")
  (c2m212isa   "fa-e-ex-traducao")

Como desenhar subconjuntos do plano
===================================
    (c2m211somas2p 48 "dirichlet-3")
    (c2m211somas2a    "dirichlet-3")


Apresentação sobre aulas por Telegram
=====================================
  (saptp 1 "title")
  (sapta   "title")
  (find-TH "2021aulas-por-telegram")
  (find-TH "2018-r")
  (find-TH "2021-r")


Mudança de variável
===================
  (find-angg ".emacs" "c2-2021-1-telegram")

Caso da srta K.
  Critérios de correção / erros de sintaxe
  (c2m221dfip 5 "demonstracao-complicada")
  (c2m221dfia   "demonstracao-complicada")
  Lean

Caso do menino que queria provas formais - Grilet?
  (c2m212somas24p 1 "title")
  (c2m212somas24a   "title")
  (find-fline "~/TH/2021.1-C2.blogme")

Caso da menina da Focus que queria tudo por video
  (c2m211somas1da "video-1")
  Vivian

Critério de correção: erros que zeram as questões
  (find-pdf-page "~/2022.1-C2/C2-quadros.pdf" 1)

  Caso do 3=4:
                   2020.2: (c2m202p1p 3 "questao-1")
                           (c2m202p1a   "questao-1")
                           (c2m202p1p 8 "gabarito-1")
                           (c2m202p1a   "gabarito-1")
  Quantas pessoas erraram: (find-fline "~/2020.2-C2/P1/C1/")
                           (find-fline "~/2020.2-C2/P1/E1/")
                   2021.1: (c2m211somas2p 50 "trailer")
                           (c2m211somas2a    "trailer")

  (c2m212tudop 108 "3=4")


  Substuição trigonométrica
  -------------------------
    (find-angg ".emacs" "c2-2020-2")
    (c2m202sta "title")
    (c2m202sta "title" "Aula nn: substituição trigonométrica")
    (c2m202p2p 1 "title")
    (c2m202p2    "title")



% (c2m201tudop 1 "title")
% (c2m201tudoa   "title")
% (c2m202tudop 1 "title")
% (c2m202tudoa   "title")
% (c2m211tudop 1 "title")
% (c2m211tudoa   "title")
% (c2m212tudop 1 "title")
% (c2m212tudop 149 "for")
% (c2m212tudoa   "title")
% (c2m221tudop 1 "title")
% (c2m221tudoa   "title")


% (c2m211tudop 1 "title")
% (c2m212tudop 1 "title")
% (c2m221tudop 1 "title")

  (find-pdf-page   "~/LATEX/2022-1-C2-tudo.pdf")
  (find-pdf-text   "~/LATEX/2022-1-C2-tudo.pdf")
  (find-pdf-page   "~/LATEX/2021-2-C2-tudo.pdf")
  (find-pdf-text   "~/LATEX/2021-2-C2-tudo.pdf")
  (find-pdf-text   "~/LATEX/2021-2-C2-tudo.pdf" nil 1712)
  (find-pdf-text   "~/LATEX/2022-1-C2-tudo.pdf")

% (find-LATEXgrep "grep --color=auto -nH --null -e 'Para todo' *.tex")



Considerações finais
====================
Vocês não fazem idéia do quanto ajuda
a gente ter acesso ao material dos colegas

Eu adoraria que essa regra aqui passasse a valer:

  Quem não compartilha material dos seus cursos não tem moral pra
  criticar os cursos dos outros

Tomara que esse minha apresentação
nos ajude a dar um passinho nessa direção! =)



Erros de sintaxe

Coeficiente angular


  (find-angg ".emacs" "c2-2020-1")
  (find-angg ".emacs" "c2-2020-2")
  (find-angg ".emacs" "c2-2021-1")
  (find-angg ".emacs" "c2-2021-2")





Erro de sintaxe - isso aí não compila
Essa expressão se reduz a um número e essa outra não


  (find-angg ".emacs" "c2q192")
  (find-es "maxima" "trig-ids")



Problemas com variáveis: somatórios, d/dx f(g(x))


Maxima

Gabaritos
  viram exercícios


# Local Variables:
# coding:  utf-8-unix
# End:
