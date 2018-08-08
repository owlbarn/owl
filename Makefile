OPAM_LIB := $(shell opam config var lib 2>/dev/null)
OPAM_STUBS := $(shell opam config var stublibs 2>/dev/null)

.PHONY: all
all: build

.PHONY: depend depends
depend depends:
	dune external-lib-deps --missing @install @runtest

.PHONY: build
build: depends
	dune build @install

.PHONY: test
test: depends
	dune runtest -j 1 --no-buffer -p owl

.PHONY: clean
clean:
	dune clean

.PHONY: install
install: build
	dune install
	-[ -f "$(OPAM_LIB)/stubslibs/dllowl_stubs.so" ] \
	  && mv "$(OPAM_LIB)/stubslibs/dllowl_stubs.so" \
	        "$(OPAM_STUBS)/dllowl_stubs.so"
	-[ -f "$(OPAM_LIB)/stubslibs/dllowl_opencl_stubs.so" ] \
	  && mv "$(OPAM_LIB)/stubslibs/dllowl_opencl_stubs.so" \
	        "$(OPAM_STUBS)/dllowl_opencl_stubs.so"
	-$(RM) -d $(OPAM_LIB)/stubslibs

.PHONY: uninstall
uninstall:
	dune uninstall
	$(RM) $(OPAM_STUBS)/dllowl_stubs.so
	$(RM) $(OPAM_STUBS)/dllowl_opencl_stubs.so

.PHONY: doc
doc:
	opam install -y odoc
	dune build @doc

.PHONY: distclean cleanall
distclean cleanall:
	dune uninstall && dune clean
	$(RM) -r $(find . -name .merlin)
	$(RM) $(OPAM_STUBS)/dllowl_stubs.so
	$(RM) $(OPAM_STUBS)/dllowl_opencl_stubs.so

PKGS=owl-base,owl,owl-zoo,owl-top
.PHONY: release
release:
	make install # as package distrib steps rely on owl-base etc
	opam install --yes dune-release
	dune-release tag
	dune-release distrib
	dune-release publish

	dune-release opam pkg    --pkg-names $(PKGS)
	dune-release opam submit --pkg-names $(PKGS)
