all:
	ocaml setup.ml -build
	rm -rf examples/*.byte examples/*.native examples/*.tmp
	rm -rf perftest/*.byte perftest/*.native perftest/*.tmp
	mv perf_* perftest/
install:
	ocaml setup.ml -uninstall
	ocaml setup.ml -install
uninstall:
	ocamlfind remove owl
	ocamlfind remove owl_zoo
oasis:
	oasis setup
	ocaml setup.ml -configure
test:
	ocaml setup.ml -test
doc:
	ocaml setup.ml -doc
clean:
	rm -rf _build
	rm -rf *.byte *.native
	rm -rf examples/*.byte examples/*.native examples/*.tmp
	rm -rf perftest/*.byte perftest/*.native perftest/*.tmp
cleanall: uninstall
	rm -rf _build setup.* *.odocl myocamlbuild.ml _tags
	rm -rf `find . -name META`
	rm -rf `find . -name *.mldylib`
	rm -rf `find . -name *.mllib`
	rm -rf `find . -name *.clib`
	rm -rf `find . -name *.native`
	rm -rf `find . -name *.byte`
	rm -rf `find . -name *.tmp`
