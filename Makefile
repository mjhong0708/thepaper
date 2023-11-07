main: *.tex *.bib src/*
	if [ ! -d "build" ]; then mkdir build; fi
	latexmk -bibtex -output-directory=build -pdf -xelatex -use-make main