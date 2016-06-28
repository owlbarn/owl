all:
	ocaml setup.ml -uninstall
	ocaml setup.ml -build
	ocaml setup.ml -install
oasis:
	oasis setup
	ocaml setup.ml -configure
clean:
	rm -rf _build setup.* myocamlbuild.ml _tags
