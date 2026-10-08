DOC=document
EXPOSE=expose/expose
LATEX ?= pdflatex
LATEX_FLAGS ?= -shell-escape -interaction=nonstopmode -halt-on-error -file-line-error -synctex=1
BIBER ?= biber
BIBTEX ?= bibtex
BIB_BACKEND ?= biber
DOC_FILE ?=

DOC_SOURCES := $(DOC).tex mba.cls glossary.tex refs.bib $(wildcard content/*.tex) $(wildcard figures/*) $(wildcard format/*.bst)
EXPOSE_SOURCES := $(EXPOSE).tex expose/expose.cls refs.bib $(wildcard expose/content/*.tex) $(wildcard format/*.bst)
AUTO_TARGET := $(if $(filter expose,$(basename $(notdir $(DOC_FILE)))),expose,run)

.SUFFIXES:
.SUFFIXES: .bib .pdf .tex
.PHONY: auto run expose clean

auto: $(AUTO_TARGET)
run: $(DOC).pdf

expose: $(EXPOSE).pdf

$(DOC).backend-$(BIB_BACKEND):
	rm -f $(DOC).backend-*
	touch $@

$(EXPOSE).pdf: $(EXPOSE).bbl $(EXPOSE_SOURCES)
	cd expose && $(LATEX) $(LATEX_FLAGS) expose.tex -draftmode
	cd expose && $(LATEX) $(LATEX_FLAGS) expose.tex

$(EXPOSE).bbl: $(EXPOSE_SOURCES)
	cd expose && $(LATEX) $(LATEX_FLAGS) expose.tex -draftmode
	cd expose && $(BIBER) expose

$(DOC).pdf: $(DOC).bbl $(DOC_SOURCES)
	$(LATEX) $(LATEX_FLAGS) $(DOC).tex -draftmode
	$(LATEX) $(LATEX_FLAGS) $(DOC).tex

ifeq ($(BIB_BACKEND),biber)
$(DOC).bbl: $(DOC).backend-$(BIB_BACKEND) $(DOC_SOURCES)
	$(LATEX) $(LATEX_FLAGS) $(DOC).tex -draftmode
	$(BIBER) $(DOC)
else ifeq ($(BIB_BACKEND),bibtex)
$(DOC).aux: $(DOC).backend-$(BIB_BACKEND) $(DOC_SOURCES)
	$(LATEX) $(LATEX_FLAGS) $(DOC).tex -draftmode

$(DOC).bbl: $(DOC).aux
	$(BIBTEX) $(DOC)
else
$(error Unsupported BIB_BACKEND '$(BIB_BACKEND)'; choose biber or bibtex)
endif

clean:
	find . content expose -maxdepth 1 -type f \( -name '*.aux' -o -name '*.lof' -o -name '*.log' -o -name '*.lot' -o -name '*.lol' -o -name '*.bcf' -o -name '*.toc' -o -name '*.bbl' -o -name '*.blg' -o -name '*.run.xml' -o -name '*.out' -o -name '*.brf' -o -name '*.fdb_latexmk' -o -name '*.synctex' -o -name '*.fls' -o -name '*.xmpdata' -o -name '*.xmpi' -o -name '*.pdf' -o -name 'document.backend-*' \) -delete
