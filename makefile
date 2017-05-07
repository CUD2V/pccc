PKG_VERSION = $(shell awk '/^Version:/{print $$2}' DESCRIPTION)
PKG_NAME    = $(shell awk '/^Package:/{print $$2}' DESCRIPTION)

SRC    = $(wildcard src/*.cpp)
RFILES = $(wildcard R/*.R)
EGS    = $(wildcard examples/*.R)
VIGS   = $(wildcard vignettes/*.Rmd)

.PHONY: vignettes

all: $(PKG_NAME)_$(PKG_VERSION).tar.gz

vignettes:
	R -e "devtools::build_vignettes()"

$(PKG_NAME)_$(PKG_VERSION).tar.gz: $(RFILES) $(SRC) $(EGS) $(VIGS) DESCRIPTION
	R -e "devtools::document()"
	R CMD build .

check: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD check $(PKG_NAME)_$(PKG_VERSION).tar.gz

install: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD INSTALL $(PKG_NAME)_$(PKG_VERSION).tar.gz

clean:
	/bin/rm -rf inst/doc/
	/bin/rm -f  $(PKG_NAME)_*.tar.gz
	/bin/rm -rf $(PKG_NAME).Rcheck
