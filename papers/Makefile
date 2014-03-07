.PHONY: all eusprig-2014-open-data.pdf eusprig-2014-gastronomification.pdf

all: eusprig-2014-open-data.pdf eusprig-2014-gastronomification.pdf

eusprig-2014-open-data.pdf:
	pdflatex eusprig-2014-open-data.tex
	bibtex eusprig-2014-open-data.aux
	pdflatex eusprig-2014-open-data.tex
	pdflatex eusprig-2014-open-data.tex

eusprig-2014-gastronomification.pdf:
	pdflatex eusprig-2014-gastronomification.tex
	bibtex eusprig-2014-gastronomification.aux
	pdflatex eusprig-2014-gastronomification.tex
	pdflatex eusprig-2014-gastronomification.tex
