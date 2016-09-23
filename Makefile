all:
	ocaml setup.ml -build
	mv *.byte examples/
	ocaml setup.ml -uninstall
	ocaml setup.ml -install
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
