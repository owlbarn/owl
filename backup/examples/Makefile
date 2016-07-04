all:
	ocamlfind ocamlopt -linkpkg -o test_performance str.cmxa pretty.cmx matrix.cmx test_performance.ml -package owl -package gsl
clean:
	rm -rf *.cmi *.cmo *.cmx *.o test*.tmp test_performance test_operation
