# hx -- Hash Expression Language Specification
#
# The document is groff -mm (memorandum macros).  Building it needs groff with
# the pic and tbl preprocessors, and ps2pdf from Ghostscript.
#
#   make            build hx.pdf
#   make hx.ps      stop at PostScript
#   make clean      remove the generated PostScript and PDF
#
# SOURCE ORDER MATTERS, and not in the way it looks.
#
#   hx.1   the specification proper.  Sets the -mm registers, the page header
#          and the $Revision$ that identifies the document.
#   hx.8   Appendix A, the mdxfind type to hx expression reference.  One row
#          per registered type; this is the table other tools transcribe.
#   hx.9   the title page and the table of contents.
#
# hx.9 comes LAST even though the title page prints FIRST.  Under -mm the
# table of contents is emitted by .TC, which can only run once the body has
# been formatted and every heading collected, so the file that calls it has to
# be the final input.  Putting hx.9 first produces a document with an empty
# contents page and no error.
#
# THE FRONT MATTER COMES OUT LAST, AND IS MOVED BY HAND
#
# .TC cannot run until every heading has been collected, so groff emits the
# title page, the table of contents, the list of figures and the list of
# tables AFTER the body -- as the final pages of hx.ps, in that reversed
# order.  The published PDF has them at the front.  Moving them is a manual
# step and is not done here: this makefile builds exactly what groff produces
# and stops.
#
# So `make` does not by itself reproduce the PDF published at
# https://www.mdxfind.com/hx.pdf .  It produces its content; the page order of
# the front matter is finished by hand afterwards.  Anyone diffing the two
# should expect that difference and no other.

# THE FLAGS

#
#   -rW6.5i     set the line-length register to 6.5 inches
#   -p          pic preprocessor, for the diagrams
#   -t          tbl preprocessor, for Appendix A and the opcode tables
#   -mm         memorandum macros
#   -P -pletter pass -pletter to grops, so the PostScript declares US Letter
#   -T ps       PostScript output
#
# Dropping -p or -t does not fail: it emits the preprocessor source as
# literal text, so the diagrams and every table come out as garbage while the
# exit status stays zero.  Check the page count and one table if you change
# this rule.

GROFF   = groff
GFLAGS  = -rW6.5i -p -t -mm -P -pletter -T ps
PS2PDF  = ps2pdf
SRC     = hx.1 hx.8 hx.9

all: hx.pdf

hx.ps: $(SRC)
	$(GROFF) $(GFLAGS) $(SRC) >hx.ps

hx.pdf: hx.ps
	$(PS2PDF) hx.ps hx.pdf

clean:
	rm -f hx.ps hx.pdf

.PHONY: all clean
