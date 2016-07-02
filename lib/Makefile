all:
	ocamlfind ocamlopt -c matrix_foreign.ml -package ctypes -package ctypes.foreign
	ocamlfind ocamlopt -c utils.ml
	ocamlfind ocamlopt -c rand.mli
	ocamlfind ocamlopt -c rand.ml -package gsl
	ocamlfind ocamlopt -c pretty.mli
	ocamlfind ocamlopt -c pretty.ml
	ocamlfind ocamlopt -c matrix.mli -package gsl
	ocamlfind ocamlopt -c matrix.ml pretty.cmx rand.cmx utils.cmx matrix_foreign -package gsl
	ocamlfind ocamlopt -linkpkg -o test_performance str.cmxa pretty.cmx rand.cmx utils.cmx matrix_foreign.cmx matrix.cmx test_performance.ml -package gsl -package ctypes -package ctypes.foreign
clean:
	rm -rf *.cmi *.cmo *.cmx *.o test*.tmp test_performance test_operation
