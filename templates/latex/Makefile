.PHONY: clean all

all: main.tex
	lualatex main
	bibtex main
	lualatex main
	bibtex main
	cp main.pdf output.pdf

clean:
	rm main.aux main.bbl main.blg main.log main.out main.pdf main.toc output.pdf
