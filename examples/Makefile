all:
	ocamlfind ocamlopt -o test ctypes_exp.ml -package ctypes -package ctypes.foreign -package gsl -linkpkg
test1:
	ocamlfind ocamlopt -o test test.ml -package ctypes -package ctypes.foreign -package gsl -linkpkg
clean:
	rm -rf *.cmi *.cmo *.cmx *.o _build test
