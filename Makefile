SRC = $(wildcard resume.md)

PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
TXT=$(SRC:.md=.txt)
LATEX_TEMPLATE=./pandoc-templates/default.latex
GRAVATAR_OPTION=--no-gravatar

all:   $(PDFS) $(HTML) $(TXT)

pdf:   $(PDFS)
html:  $(HTML)
txt:   $(TXT)

%.html: %.md
	python resume.py html $(GRAVATAR_OPTION) < $< | pandoc -t html -c resume.css -o $@

%.pdf:  %.md $(LATEX_TEMPLATE)
	python resume.py tex < $< | pandoc --template=$(LATEX_TEMPLATE) -H header.tex -o $@
	
%.txt:  %.md
	cp resume.md resume.txt

$(LATEX_TEMPLATE):
	git submodule update --init
