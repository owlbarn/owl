.PHONY: all
all: build

.PHONY: build
build: depends
	jbuilder build @install

.PHONY: depend depends
depend depends:
	jbuilder external-lib-deps --missing @install

.PHONY: clean
clean:
	jbuilder clean

.PHONY: test
test:
	jbuilder runtest -j1 --no-buffer

.PHONY: install
install:
	jbuilder install
	# sigh, the following code deals with the OPAM bug :(
	$(eval WRONG_DST=${OPAM_SWITCH_PREFIX}/lib/stubslibs/dllowl_stubs.so)
	$(eval RIGHT_DST=${OPAM_SWITCH_PREFIX}/lib/stublibs/dllowl_stubs.so)
	if [ -f ${WRONG_DST} ]; then mv ${WRONG_DST} ${RIGHT_DST}; fi

.PHONY: uninstall
uninstall:
	jbuilder uninstall

.PHONY: doc
doc:
	jbuilder build @doc

.PHONY: cleanall
cleanall:
	jbuilder uninstall && jbuilder clean
	$(RM) -r $(find . -name .merlin)
