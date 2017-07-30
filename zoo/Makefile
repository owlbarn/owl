all:
	atdgen -t *.atd
	atdgen -j *.atd
	ocamlfind ocamlopt -linkpkg -package atdgen,owl -o test \
		owl_zoo_specs_neural_t.mli owl_zoo_specs_neural_t.ml \
		owl_zoo_specs_neural_j.mli owl_zoo_specs_neural_j.ml \
    owl_zoo_specs_neural.ml

	ocamlfind ocamlc -linkpkg -package owl,ocaml-compiler-libs.toplevel,findlib.top owl_zoo_toplevel.ml

	ocamlfind ocamlc -linkpkg -package owl,compiler-libs.common,ocaml-compiler-libs.toplevel \
		-o owl_zoo \
    owl_zoo.ml
clean:
	rm -rf *.byte *.native *.cmi *.cmx *.cmo *.o
	rm -rf test*
