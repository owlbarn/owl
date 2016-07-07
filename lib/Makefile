all:
	ocamlfind ocamlopt -c types.ml -package ctypes
	ocamlfind ocamlopt -c matrix_foreign.ml -package ctypes -package ctypes.foreign
	ocamlfind ocamlopt -c utils.ml
	ocamlfind ocamlopt -c rand.mli
	ocamlfind ocamlopt -c rand.ml -package gsl
	ocamlfind ocamlopt -c pretty.mli
	ocamlfind ocamlopt -c pretty.ml
	ocamlfind ocamlopt -c matrix.mli -package gsl -package ctypes
	ocamlfind ocamlopt -c matrix.ml pretty.cmx rand.cmx utils.cmx matrix_foreign.cmx -package gsl -package ctypes
	ocamlfind ocamlopt -c learn.ml pretty.cmx rand.cmx utils.cmx matrix_foreign.cmx -package gsl -package ctypes
	ocamlfind ocamlopt -linkpkg -o test_performance types.cmx pretty.cmx rand.cmx utils.cmx matrix_foreign.cmx matrix.cmx test_performance.ml -package gsl -package ctypes -package ctypes.foreign
	ocamlfind ocamlopt -linkpkg -o test_kmeans types.cmx pretty.cmx rand.cmx utils.cmx matrix_foreign.cmx matrix.cmx learn.cmx test_kmeans.ml -package gsl -package ctypes -package ctypes.foreign
	ocamlfind ocamlopt -linkpkg -o test_sgd types.cmx pretty.cmx rand.cmx utils.cmx matrix_foreign.cmx matrix.cmx learn.cmx test_sgd.ml -package gsl -package ctypes -package ctypes.foreign
	ocamlfind ocamlopt -linkpkg -o test_svm types.cmx pretty.cmx rand.cmx utils.cmx matrix_foreign.cmx matrix.cmx learn.cmx test_svm.ml -package gsl -package ctypes -package ctypes.foreign
clean:
	rm -rf *.cmi *.cmo *.cmx *.o test*.tmp test_performance test_operation test_sgd
