all:
	ocaml setup.ml -build
	ocaml setup.ml -uninstall
	ocaml setup.ml -install
	mv test_* examples/
oasis:
	oasis setup
	ocaml setup.ml -configure
clean:
	rm -rf _build
	rm -rf examples/*.byte examples/*.native examples/*.tmp
cleanall:
	rm -rf _build setup.* myocamlbuild.ml _tags
	rm -rf lib/META lib/*.mldylib lib/*.mllib
	rm -rf examples/*.byte examples/*.native examples/*.tmp
