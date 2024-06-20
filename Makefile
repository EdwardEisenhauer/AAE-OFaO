BUILDDIR = `pwd`/build
OUTDIR = `pwd`/out
LATEX_OPTIONS = -pdf -halt-on-error

PACKAGE_NAME = WUSTReport
SOURCE_DIRS = Laboratory_1/ Laboratory_3/
PDFBUILDS = $(addprefix $(BUILDDIR)/, $(SOURCE_DIRS:/=.pdf))

.DEFAULT_GOAL := all

.PHONY : clean
clean :
	-rm -r $(BUILDDIR)

.PHONY : all
all : sty $(PDFBUILDS)

.PHONY : sty
sty : $(PACKAGE_NAME).sty
$(PACKAGE_NAME).sty : $(PACKAGE_NAME)/$(PACKAGE_NAME).ins $(PACKAGE_NAME)/$(PACKAGE_NAME).dtx
	mkdir -p $(BUILDDIR)
	cd $(PACKAGE_NAME) && \
		yes | latex $(PACKAGE_NAME).ins
	cp $(PACKAGE_NAME)/$@ $(BUILDDIR)/$@
	cp $(PACKAGE_NAME)/logo-pwr-2016.pdf $(BUILDDIR)/logo-pwr-2016.pdf

$(PDFBUILDS) : $(BUILDDIR)/%.pdf: sty
	mkdir -p $(BUILDDIR)
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=$* \
		-output-directory=$(BUILDDIR) \
		$*/main
	mkdir -p $(OUTDIR)
	cp $@ $(OUTDIR)/$*.pdf
