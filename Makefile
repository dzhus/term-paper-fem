PDFLATEX := pdflatex -shell-escape
BIBTEX := bibtex8 -B
NOTANGLE := notangle
NOWEAVE := noweave -n

DOCNAME := paper

include ${DOCNAME}-deps.mk

.PHONY: doc

doc: ${DOCNAME}.pdf

${DOCNAME}-deps.mk: ${DOCNAME}.tex
	texdepend -o $@ -print=if $<

${DOCNAME}.aux: ${DOCNAME}.tex ${DOCNAME}.bib ${INCLUDES}
	${PDFLATEX} ${DOCNAME}
	${BIBTEX} ${DOCNAME}

${DOCNAME}.pdf: ${DOCNAME}.aux
	${PDFLATEX} ${DOCNAME}
	${PDFLATEX} ${DOCNAME}

fem.tex: fem.py.nw
	${NOWEAVE} $< > $@

fem.py: fem.py.nw
	${NOTANGLE} $< > $@
