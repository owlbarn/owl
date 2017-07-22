all:
	atdgen -t *.atd
	atdgen -j *.atd
	ocamlfind ocamlopt -linkpkg -package atdgen,owl -o test \
		owl_zoo_specs_neural_t.mli owl_zoo_specs_neural_t.ml \
		owl_zoo_specs_neural_j.mli owl_zoo_specs_neural_j.ml \
    owl_zoo_neural.ml
clean:
	rm -rf *.byte *.native *.cmi *.cmx *.o
