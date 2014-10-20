.PHONY: all eusprig-2014-open-data.pdf eusprig-2014-sheetmusic.pdf

all: eusprig-2014-open-data.pdf eusprig-2014-sheetmusic.pdf

eusprig-2014-open-data.pdf:
	rm -f eusprig-2014-open-data.{aux,bbl,blg,pdf}
	pdflatex eusprig-2014-open-data.tex
	bibtex eusprig-2014-open-data.aux
	pdflatex eusprig-2014-open-data.tex
	pdflatex eusprig-2014-open-data.tex

eusprig-2014-sheetmusic.pdf:
	rm -f eusprig-2014-sheetmusic.{aux,bbl,blg,pdf}
	pdflatex eusprig-2014-sheetmusic.tex
	bibtex eusprig-2014-sheetmusic.aux
	pdflatex eusprig-2014-sheetmusic.tex
	pdflatex eusprig-2014-sheetmusic.tex
