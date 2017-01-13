all:
	ocaml setup.ml -build
	rm -rf examples/*.byte examples/*.native examples/*.tmp
	rm -rf perftest/*.byte perftest/*.native perftest/*.tmp
	mv test_* examples/
	mv perf_* perftest/
install:
	ocaml setup.ml -uninstall
	ocaml setup.ml -install
oasis:
	oasis setup
	ocaml setup.ml -configure
doc:
	ocaml setup.ml -doc
clean:
	rm -rf _build
	rm -rf *.byte *.native
	rm -rf examples/*.byte examples/*.native examples/*.tmp
	rm -rf perftest/*.byte perftest/*.native perftest/*.tmp
cleanall:
	# remove intermediate files
	rm -rf _build setup.* *.odocl myocamlbuild.ml _tags
	rm -rf `find . -name META`
	rm -rf `find . -name *.mldylib`
	rm -rf `find . -name *.mllib`
	rm -rf `find . -name *.clib`
	rm -rf `find . -name *.native`
	rm -rf `find . -name *.byte`
	rm -rf `find . -name *.tmp`
	# remove installed library files
	ocamlfind remove owl
	ocamlfind remove owl_topic
	ocamlfind remove owl_parallel
