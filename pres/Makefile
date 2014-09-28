# Makefile for proposal and report

LATEX  = pdflatex
DOT    = dot
DOTFRM = -T
DOTOUT = -o
RM     = rm -f
LTFS   = *.aux *.lof *.log *.lot *.fls *.out *.toc *.snm *.nav *.pdf
IMGS   = directed.pdf undirected.pdf deb.pdf

all: pres.pdf

%.pdf: %.tex $(IMGS)
	$(LATEX) $<
	$(LATEX) $<

.PRECIOUS: %.pdf
%.pdf: %.dot
	$(DOT) $(DOTFRM) pdf $(DOTOUT) $@ $<

.PRECIOUS: %.aux
%.aux: %.tex
	$(LATEX) $<

.PHONY: clean
clean:
	$(RM) $(LTFS) $(DOCS) $(BIBS) $(IDXS) $(OTHER)

