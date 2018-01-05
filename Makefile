.PHONY: all
all:
	jbuilder build --dev

.PHONY: clean
clean:
	jbuilder clean

.PHONY: test
test:
	jbuilder runtest -j1 --no-buffer

.PHONY: install
install:
	jbuilder install

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
