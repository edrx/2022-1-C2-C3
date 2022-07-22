# This file:
#   http://angg.twu.net/2022-1-C2-C3/Makefile.html
#   http://angg.twu.net/2022-1-C2-C3/Makefile
#           (find-angg "2022-1-C2-C3/Makefile")
# Author: Eduardo Ochs <eduardoochs@gmail.com>
#
# Created by hand from:
#   (find-angg "2022-1-C2-C3/README.org")
#   (find-fline "/tmp/.filest0.tex")
#   (setq last-kbd-macro (kbd "C-a C-q TAB lualatex SPC C-a <down>"))

all: compile_all_texs

compile_basic_texs:
	lualatex 2022-1-C2-MT1.tex
	lualatex 2022-1-C2-MT2.tex
	lualatex 2022-1-C2-P1.tex
	lualatex 2022-1-C2-P2.tex
	lualatex 2022-1-C2-TFC1.tex
	lualatex 2022-1-C2-VR.tex
	lualatex 2022-1-C2-algumas-t-ints.tex
	lualatex 2022-1-C2-der-fun-inv.tex
	lualatex 2022-1-C2-dicas-pra-P1.tex
	lualatex 2022-1-C2-dicas-pra-P2.tex
	lualatex 2022-1-C2-infs-e-sups.tex
	lualatex 2022-1-C2-intro.tex
	lualatex 2022-1-C2-primitivas.tex
	lualatex 2022-1-C2-somas-3.tex
	lualatex 2022-1-C3-MT1.tex
	lualatex 2022-1-C3-MT2.tex
	lualatex 2022-1-C3-P1.tex
	lualatex 2022-1-C3-P2.tex
	lualatex 2022-1-C3-funcoes-homogeneas.tex
	lualatex 2022-1-C3-notacao-de-fisicos.tex
	lualatex 2022-1-C3-orbita.tex

compile_all_texs:
	lualatex 2022-1-C2-MT1.tex
	lualatex 2022-1-C2-MT2.tex
	lualatex 2022-1-C2-P1.tex
	lualatex 2022-1-C2-P2.tex
	lualatex 2022-1-C2-TFC1.tex
	lualatex 2022-1-C2-VR.tex
	lualatex 2022-1-C2-algumas-t-ints.tex
	lualatex 2022-1-C2-der-fun-inv.tex
	lualatex 2022-1-C2-dicas-pra-P1.tex
	lualatex 2022-1-C2-dicas-pra-P2.tex
	lualatex 2022-1-C2-infs-e-sups.tex
	lualatex 2022-1-C2-intro.tex
	lualatex 2022-1-C2-primitivas.tex
	lualatex 2022-1-C2-somas-3.tex
	lualatex 2022-1-C3-MT1.tex
	lualatex 2022-1-C3-MT2.tex
	lualatex 2022-1-C3-P1.tex
	lualatex 2022-1-C3-P2.tex
	lualatex 2022-1-C3-funcoes-homogeneas.tex
	lualatex 2022-1-C3-notacao-de-fisicos.tex
	lualatex 2022-1-C3-orbita.tex
	lualatex 2022-1-C2-tudo.tex
	lualatex 2022-1-C3-tudo.tex
