BUILDDIR = `pwd`/build
LATEX_OPTIONS = -pdf

SOURCE_DIRS = $(shell ls -d */ | grep -v "^build")
PDFBUILDS = $(addprefix $(BUILDDIR)/, $(SOURCE_DIRS:/=.pdf))

.DEFAULT_GOAL := all

.PHONY : clean
clean :
	-rm -r $(BUILDDIR)

.PHONY : all
all : $(PDFBUILDS)

$(PDFBUILDS) : $(BUILDDIR)/%.pdf:
	mkdir -p $(BUILDDIR)
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=$* \
		-output-directory=$(BUILDDIR) \
		$*/main
