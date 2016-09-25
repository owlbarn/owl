all:
	ocaml setup.ml -build
	mv test_* examples/
install:
	ocaml setup.ml -uninstall
	ocaml setup.ml -install
oasis:
	oasis setup
	ocaml setup.ml -configure
clean:
	rm -rf _build
	rm -rf *.byte *.native examples/*.byte examples/*.native examples/*.tmp
cleanall:
	rm -rf _build setup.* myocamlbuild.ml _tags
	rm -rf lib/META lib/*.mldylib lib/*.mllib
	rm -rf *.byte *.native examples/*.byte examples/*.native examples/*.tmp
