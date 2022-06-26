# This file:
#   http://angg.twu.net/2022-1-C2-C3/Makefile.html
#   http://angg.twu.net/2022-1-C2-C3/Makefile
#           (find-angg "2022-1-C2-C3/Makefile")
# Author: Eduardo Ochs <eduardoochs@gmail.com>

all: compile_all_texs

compile_basic_texs:
	lualatex 2022-1-C2-MT1.tex
	lualatex 2022-1-C2-TFC1.tex
	lualatex 2022-1-C2-infs-e-sups.tex
	lualatex 2022-1-C2-intro.tex
	lualatex 2022-1-C2-somas-3.tex
	lualatex 2022-1-C3-MT1.tex
	lualatex 2022-1-C3-notacao-de-fisicos.tex

compile_all_texs:
	lualatex 2022-1-C2-MT1.tex
	lualatex 2022-1-C2-TFC1.tex
	lualatex 2022-1-C2-infs-e-sups.tex
	lualatex 2022-1-C2-intro.tex
	lualatex 2022-1-C2-somas-3.tex
	lualatex 2022-1-C3-MT1.tex
	lualatex 2022-1-C3-notacao-de-fisicos.tex
	lualatex 2022-1-C2-tudo.tex
	lualatex 2022-1-C3-tudo.tex
