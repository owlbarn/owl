all:
	ocamlfind ocamlopt -c utils.ml
	ocamlfind ocamlopt -c rand.mli
	ocamlfind ocamlopt -c rand.ml -package gsl
	ocamlfind ocamlopt -c pretty.mli
	ocamlfind ocamlopt -c pretty.ml
	ocamlfind ocamlopt -c matrix.mli
	ocamlfind ocamlopt -c matrix.ml pretty.cmx rand.cmx utils.cmx -package gsl
	ocamlfind ocamlopt -linkpkg -o test_performance str.cmxa pretty.cmx rand.cmx utils.cmx matrix.cmx test_performance.ml -package gsl
clean:
	rm -rf *.cmi *.cmo *.cmx *.o test*.tmp test_performance test_operation
