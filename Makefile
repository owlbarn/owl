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
	rm -rf _build setup.* myocamlbuild.ml _tags
	rm -rf lib/META lib/*.mldylib lib/*.mllib lib/libowl_stubs.clib
	rm -rf lib/bindings/META lib/bindings/*.mldylib lib/bindings/*.mllib
	rm -rf lib/topic/META lib/topic/*.mldylib lib/topic/*.mllib
	rm -rf lib/eigen/META lib/eigen/*.mldylib lib/eigen/*.mllib lib/eigen/*.clib
	rm -rf *.byte *.native
	rm -rf examples/*.byte examples/*.native examples/*.tmp
	rm -rf perftest/*.byte perftest/*.native perftest/*.tmp
	# remove installed library files
	ocamlfind remove owl
	ocamlfind remove owl_topic
	ocamlfind remove owl_parallel
