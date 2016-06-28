all:
	ocamlfind ocamlopt -c matrix.ml -package gsl
	ocamlfind ocamlopt -linkpkg -o test_performance str.cmxa matrix.cmx test_performance.ml -package gsl
clean:
	rm -rf *.cmi *.cmo *.cmx *.o test*.tmp test_performance test_operation
