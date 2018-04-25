OPAM_LIB := $(shell opam config var lib 2>/dev/null)
OPAM_STUBS := $(shell opam config var stublibs 2>/dev/null)

.PHONY: all
all: build

.PHONY: depend depends
depend depends:
	jbuilder external-lib-deps --missing @install @runtest

.PHONY: build
build: depends
	jbuilder build @install

.PHONY: test
test: depends
	jbuilder runtest -j 1 --no-buffer -p owl

.PHONY: clean
clean:
	jbuilder clean

.PHONY: install
install: build
	jbuilder install
	-[ -f "$(OPAM_LIB)/stubslibs/dllowl_stubs.so" ] \
	  && mv "$(OPAM_LIB)/stubslibs/dllowl_stubs.so" \
	        "$(OPAM_STUBS)/dllowl_stubs.so"
	-$(RM) -d $(OPAM_LIB)/stubslibs

.PHONY: uninstall
uninstall:
	jbuilder uninstall
	$(RM) $(OPAM_STUBS)/dllowl_stubs.so

.PHONY: doc
doc:
	jbuilder build @doc

.PHONY: cleanall
cleanall:
	jbuilder uninstall && jbuilder clean
	$(RM) -r $(find . -name .merlin)
	$(RM) $(OPAM_STUBS)/dllowl_stubs.so

.PHONY: release
release:
	opam install --yes tls topkg topkg-care topkg-jbuilder opam-publish
	topkg tag
	topkg distrib
	topkg publish

	topkg opam pkg
	topkg opam submit

	topkg opam pkg --pkg-name owl
	topkg opam submit --pkg-name owl

	topkg opam pkg --pkg-name owl-zoo
	topkg opam submit --pkg-name owl-zoo

	topkg opam pkg --pkg-name owl-top
	topkg opam submit --pkg-name owl-top
